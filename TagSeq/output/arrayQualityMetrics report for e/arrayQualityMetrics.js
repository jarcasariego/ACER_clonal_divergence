// (C) Wolfgang Huber 2010-2011

// Script parameters - these are set up by R in the function 'writeReport' when copying the 
//   template for this script from arrayQualityMetrics/inst/scripts into the report.

var highlightInitial = [ false, false, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
var arrayMetadata    = [ [ "1", "N45_S", "LP15", "P168RNA", "N45", "C1733", "1", "0", "shallow", "C1733.LP15" ], [ "2", "N68_S", "LP15", "P169RNA", "N68", "C1732", "2", "0", "shallow", "C1732.LP15" ], [ "3", "N68_D", "LP40", "P171RNA", "N68", "C1732", "2", "1", "deep", "C1732.LP40" ], [ "4", "N85_D", "LP40", "P172RNA", "N85", "C1708", "3", "1", "deep", "C1708.LP40" ], [ "5", "N43_D", "LP40", "P174RNA", "N43", "C1727", "4", "1", "deep", "C1727.LP40" ], [ "6", "N45_D", "LP40", "P176RNA", "N45", "C1733", "1", "1", "deep", "C1733.LP40" ], [ "7", "N12_D", "LP40", "P315RNA", "N12", "C1741", "5", "1", "deep", "C1741.LP40" ], [ "8", "V41_S", "LP15", "P408RNA", "V41", "C1701", "6", "0", "shallow", "C1701.LP15" ], [ "9", "N66_S", "LP15", "P500RNA", "N66", "C1691", "7", "0", "shallow", "C1691.LP15" ], [ "10", "N11_D", "LP40", "P501RNA", "N11", "C1683", "8", "1", "deep", "C1683.LP40" ], [ "11", "N35_S", "LP15", "P502RNA", "N35", "C1725", "9", "0", "shallow", "C1725.LP15" ], [ "12", "V57_S", "LP15", "P503RNA", "V57", "C1703", "10", "0", "shallow", "C1703.LP15" ], [ "13", "N35_D", "LP40", "P504RNA", "N35", "C1725", "9", "1", "deep", "C1725.LP40" ], [ "14", "N43_S", "LP15", "P506RNA", "N43", "C1727", "4", "0", "shallow", "C1727.LP15" ], [ "15", "N90_S", "LP15", "P507RNA", "N90", "C1722", "11", "0", "shallow", "C1722.LP15" ], [ "16", "N11_S", "LP15", "P508RNA", "N11", "C1683", "8", "0", "shallow", "C1683.LP15" ], [ "17", "N36_S", "LP15", "P509RNA", "N36", "C1713", "12", "0", "shallow", "C1713.LP15" ], [ "18", "V57_D", "LP40", "P510RNA", "V57", "C1703", "10", "1", "deep", "C1703.LP40" ], [ "19", "N36_D", "LP40", "P511RNA", "N36", "C1713", "12", "1", "deep", "C1713.LP40" ], [ "20", "N66_D", "LP40", "P512RNA", "N66", "C1691", "7", "1", "deep", "C1691.LP40" ], [ "21", "N86_D", "LP40", "P514RNA", "N86", "C1691", "7", "1", "deep", "C1691.LP40" ], [ "22", "N90_D", "LP40", "P515RNA", "N90", "C1722", "11", "1", "deep", "C1722.LP40" ], [ "23", "N12_S", "LP15", "P517RNA", "N12", "C1741", "5", "0", "shallow", "C1741.LP15" ], [ "24", "V41_D", "LP40", "P518RNA", "V41", "C1701", "6", "1", "deep", "C1701.LP40" ], [ "25", "N86_S", "LP15", "P520RNA", "N86", "C1691", "7", "0", "shallow", "C1691.LP15" ], [ "26", "N85_S", "LP15", "P523RNA", "N85", "C1708", "3", "0", "shallow", "C1708.LP15" ] ];
var svgObjectNames   = [ "pca", "dens" ];

var cssText = ["stroke-width:1; stroke-opacity:0.4",
               "stroke-width:3; stroke-opacity:1" ];

// Global variables - these are set up below by 'reportinit'
var tables;             // array of all the associated ('tooltips') tables on the page
var checkboxes;         // the checkboxes
var ssrules;


function reportinit() 
{
 
    var a, i, status;

    /*--------find checkboxes and set them to start values------*/
    checkboxes = document.getElementsByName("ReportObjectCheckBoxes");
    if(checkboxes.length != highlightInitial.length)
	throw new Error("checkboxes.length=" + checkboxes.length + "  !=  "
                        + " highlightInitial.length="+ highlightInitial.length);
    
    /*--------find associated tables and cache their locations------*/
    tables = new Array(svgObjectNames.length);
    for(i=0; i<tables.length; i++) 
    {
        tables[i] = safeGetElementById("Tab:"+svgObjectNames[i]);
    }

    /*------- style sheet rules ---------*/
    var ss = document.styleSheets[0];
    ssrules = ss.cssRules ? ss.cssRules : ss.rules; 

    /*------- checkboxes[a] is (expected to be) of class HTMLInputElement ---*/
    for(a=0; a<checkboxes.length; a++)
    {
	checkboxes[a].checked = highlightInitial[a];
        status = checkboxes[a].checked; 
        setReportObj(a+1, status, false);
    }

}


function safeGetElementById(id)
{
    res = document.getElementById(id);
    if(res == null)
        throw new Error("Id '"+ id + "' not found.");
    return(res)
}

/*------------------------------------------------------------
   Highlighting of Report Objects 
 ---------------------------------------------------------------*/
function setReportObj(reportObjId, status, doTable)
{
    var i, j, plotObjIds, selector;

    if(doTable) {
	for(i=0; i<svgObjectNames.length; i++) {
	    showTipTable(i, reportObjId);
	} 
    }

    /* This works in Chrome 10, ssrules will be null; we use getElementsByClassName and loop over them */
    if(ssrules == null) {
	elements = document.getElementsByClassName("aqm" + reportObjId); 
	for(i=0; i<elements.length; i++) {
	    elements[i].style.cssText = cssText[0+status];
	}
    } else {
    /* This works in Firefox 4 */
    for(i=0; i<ssrules.length; i++) {
        if (ssrules[i].selectorText == (".aqm" + reportObjId)) {
		ssrules[i].style.cssText = cssText[0+status];
		break;
	    }
	}
    }

}

/*------------------------------------------------------------
   Display of the Metadata Table
  ------------------------------------------------------------*/
function showTipTable(tableIndex, reportObjId)
{
    var rows = tables[tableIndex].rows;
    var a = reportObjId - 1;

    if(rows.length != arrayMetadata[a].length)
	throw new Error("rows.length=" + rows.length+"  !=  arrayMetadata[array].length=" + arrayMetadata[a].length);

    for(i=0; i<rows.length; i++) 
 	rows[i].cells[1].innerHTML = arrayMetadata[a][i];
}

function hideTipTable(tableIndex)
{
    var rows = tables[tableIndex].rows;

    for(i=0; i<rows.length; i++) 
 	rows[i].cells[1].innerHTML = "";
}


/*------------------------------------------------------------
  From module 'name' (e.g. 'density'), find numeric index in the 
  'svgObjectNames' array.
  ------------------------------------------------------------*/
function getIndexFromName(name) 
{
    var i;
    for(i=0; i<svgObjectNames.length; i++)
        if(svgObjectNames[i] == name)
	    return i;

    throw new Error("Did not find '" + name + "'.");
}


/*------------------------------------------------------------
  SVG plot object callbacks
  ------------------------------------------------------------*/
function plotObjRespond(what, reportObjId, name)
{

    var a, i, status;

    switch(what) {
    case "show":
	i = getIndexFromName(name);
	showTipTable(i, reportObjId);
	break;
    case "hide":
	i = getIndexFromName(name);
	hideTipTable(i);
	break;
    case "click":
        a = reportObjId - 1;
	status = !checkboxes[a].checked;
	checkboxes[a].checked = status;
	setReportObj(reportObjId, status, true);
	break;
    default:
	throw new Error("Invalid 'what': "+what)
    }
}

/*------------------------------------------------------------
  checkboxes 'onchange' event
------------------------------------------------------------*/
function checkboxEvent(reportObjId)
{
    var a = reportObjId - 1;
    var status = checkboxes[a].checked;
    setReportObj(reportObjId, status, true);
}


/*------------------------------------------------------------
  toggle visibility
------------------------------------------------------------*/
function toggle(id){
  var head = safeGetElementById(id + "-h");
  var body = safeGetElementById(id + "-b");
  var hdtxt = head.innerHTML;
  var dsp;
  switch(body.style.display){
    case 'none':
      dsp = 'block';
      hdtxt = '-' + hdtxt.substr(1);
      break;
    case 'block':
      dsp = 'none';
      hdtxt = '+' + hdtxt.substr(1);
      break;
  }  
  body.style.display = dsp;
  head.innerHTML = hdtxt;
}
