// (C) Wolfgang Huber 2010-2011

// Script parameters - these are set up by R in the function 'writeReport' when copying the 
//   template for this script from arrayQualityMetrics/inst/scripts into the report.

var highlightInitial = [ true, true, true, false, false, true, true, false, true, false, true, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
var arrayMetadata    = [ [ "1", "AC163A", "AC163", "Control", "A", "60", "A.Control", "60.Control", "0.831234730232893" ], [ "2", "AC164A", "AC164", "Control", "A", "60", "A.Control", "60.Control", "0.796209021744187" ], [ "3", "AC164Pp", "AC164", "Control", "Pp", "60", "Pp.Control", "60.Control", "0.769476720778805" ], [ "4", "AC166Pp", "AC166", "Control", "Pp", "71", "Pp.Control", "71.Control", "0.912950714835407" ], [ "5", "AC167Pp", "AC167", "Control", "Pp", "60", "Pp.Control", "60.Control", "0.93943186064046" ], [ "6", "AC169A", "AC169", "Control", "A", "71", "A.Control", "71.Control", "0.879089341345107" ], [ "7", "AC170A", "AC170", "Control", "A", "71", "A.Control", "71.Control", "0.825758314079409" ], [ "8", "AC170Pp", "AC170", "Control", "Pp", "71", "Pp.Control", "71.Control", "1.40215105876886" ], [ "9", "AC172A", "AC172", "Control", "A", "60", "A.Control", "60.Control", "0.831596415285822" ], [ "10", "AC172Pp", "AC172", "Control", "Pp", "60", "Pp.Control", "60.Control", "1.70694459814431" ], [ "11", "AC174A", "AC174", "Control", "A", "71", "A.Control", "71.Control", "1.11691896284966" ], [ "12", "AC174Pp", "AC174", "Control", "Pp", "71", "Pp.Control", "71.Control", "1.4473895753669" ], [ "13", "AC175A", "AC175", "LtH_7", "A", "71", "A.LtH_7", "71.LtH_7", "0.736996565493563" ], [ "14", "AC175Pp", "AC175", "LtH_7", "Pp", "71", "Pp.LtH_7", "71.LtH_7", "1.38190200236586" ], [ "15", "AC176A", "AC176", "LtH_7", "A", "71", "A.LtH_7", "71.LtH_7", "0.939029652732787" ], [ "16", "AC176Pp", "AC176", "LtH_7", "Pp", "71", "Pp.LtH_7", "71.LtH_7", "1.02280977959797" ], [ "17", "AC177A", "AC177", "LtH_6", "A", "60", "A.LtH_6", "60.LtH_6", "0.860185059625795" ], [ "18", "AC177Pp", "AC177", "LtH_6", "Pp", "60", "Pp.LtH_6", "60.LtH_6", "1.22641521552645" ], [ "19", "AC178A", "AC178", "LtH_7", "A", "60", "A.LtH_7", "60.LtH_7", "0.837794148151658" ], [ "20", "AC178Pp", "AC178", "LtH_7", "Pp", "60", "Pp.LtH_7", "60.LtH_7", "0.960402716933357" ], [ "21", "AC179A", "AC179", "LtH_6", "A", "71", "A.LtH_6", "71.LtH_6", "0.81894017156825" ], [ "22", "AC179Pp", "AC179", "LtH_7", "Pp", "71", "Pp.LtH_7", "71.LtH_7", "1.35530417823182" ], [ "23", "AC180A", "AC180", "LtH_7", "A", "71", "A.LtH_7", "71.LtH_7", "0.948304620563878" ], [ "24", "AC181A", "AC181", "LtH_6", "A", "60", "A.LtH_6", "60.LtH_6", "1.22262051411508" ], [ "25", "AC181Pp", "AC181", "LtH_6", "Pp", "60", "Pp.LtH_6", "60.LtH_6", "1.53651943452366" ], [ "26", "AC182A", "AC182", "LtH_6", "A", "60", "A.LtH_6", "60.LtH_6", "0.977826919513199" ], [ "27", "AC182Pp", "AC182", "LtH_6", "Pp", "60", "Pp.LtH_6", "60.LtH_6", "0.946038899947584" ], [ "28", "AC183A", "AC183", "LtH_6", "A", "71", "A.LtH_6", "71.LtH_6", "0.910426312553818" ], [ "29", "AC183Pp", "AC183", "LtH_6", "Pp", "71", "Pp.LtH_6", "71.LtH_6", "1.1590487563633" ], [ "30", "AC184A", "AC184", "LtH_6", "A", "71", "A.LtH_6", "71.LtH_6", "0.853090823251741" ], [ "31", "AC184Pp", "AC184", "LtH_6", "Pp", "71", "Pp.LtH_6", "71.LtH_6", "1.11969041299027" ], [ "32", "AC185Pp", "AC185", "LtH_7", "Pp", "60", "Pp.LtH_7", "60.LtH_7", "1.03003704462588" ], [ "33", "AC186A", "AC186", "LtH_7", "A", "60", "A.LtH_7", "60.LtH_7", "0.820861218227433" ], [ "34", "AC186Pp", "AC186", "LtH_7", "Pp", "60", "Pp.LtH_7", "60.LtH_7", "0.939753234394097" ], [ "35", "AC187A", "AC187", "Hyp_T2h", "A", "60", "A.Hyp_T2h", "60.Hyp_T2h", "1.06609127785278" ], [ "36", "AC187Pp", "AC187", "Hyp_T2h", "Pp", "60", "Pp.Hyp_T2h", "60.Hyp_T2h", "1.04971169952169" ], [ "37", "AC188A", "AC188", "Hyp_T2h", "A", "60", "A.Hyp_T2h", "60.Hyp_T2h", "0.778817107461324" ], [ "38", "AC188Pp", "AC188", "Hyp_T2h", "Pp", "60", "Pp.Hyp_T2h", "60.Hyp_T2h", "1.0456600656298" ], [ "39", "AC189A", "AC189", "Hyp_T2h", "A", "60", "A.Hyp_T2h", "60.Hyp_T2h", "0.9721238390935" ], [ "40", "AC189Pp", "AC189", "Hyp_T2h", "Pp", "60", "Pp.Hyp_T2h", "60.Hyp_T2h", "0.969117422709213" ], [ "41", "AC190A", "AC190", "Hyp_T6h", "A", "60", "A.Hyp_T6h", "60.Hyp_T6h", "1.08431300870508" ], [ "42", "AC190Pp", "AC190", "Hyp_T6h", "Pp", "60", "Pp.Hyp_T6h", "60.Hyp_T6h", "0.959872088240956" ], [ "43", "AC191A", "AC191", "Hyp_T6h", "A", "60", "A.Hyp_T6h", "60.Hyp_T6h", "0.98334630039533" ], [ "44", "AC191Pp", "AC191", "Hyp_T6h", "Pp", "60", "Pp.Hyp_T6h", "60.Hyp_T6h", "0.931076702639457" ], [ "45", "AC192A", "AC192", "Hyp_T6h", "A", "60", "A.Hyp_T6h", "60.Hyp_T6h", "0.975323773039682" ], [ "46", "AC192Pp", "AC192", "Hyp_T6h", "Pp", "60", "Pp.Hyp_T6h", "60.Hyp_T6h", "1.31012464421986" ], [ "47", "AC193A", "AC193", "Recovery", "A", "60", "A.Recovery", "60.Recovery", "1.0011538393989" ], [ "48", "AC194A", "AC194", "Recovery", "A", "60", "A.Recovery", "60.Recovery", "1.07573483289279" ], [ "49", "AC194Pp", "AC194", "Recovery", "Pp", "60", "Pp.Recovery", "60.Recovery", "0.988678114781699" ], [ "50", "AC195A", "AC195", "Recovery", "A", "60", "A.Recovery", "60.Recovery", "0.824294690989593" ], [ "51", "AC195Pp", "AC195", "Recovery", "Pp", "60", "Pp.Recovery", "60.Recovery", "0.762785348228665" ], [ "52", "AC196A", "AC196", "Reox", "A", "60", "A.Reox", "60.Reox", "0.995718874983818" ], [ "53", "AC196Pp", "AC196", "Reox", "Pp", "60", "Pp.Reox", "60.Reox", "0.82265674443207" ], [ "54", "AC197A", "AC197", "Reox", "A", "60", "A.Reox", "60.Reox", "0.776964470027177" ], [ "55", "AC197Pp", "AC197", "Reox", "Pp", "60", "Pp.Reox", "60.Reox", "0.96169437125741" ], [ "56", "AC198A", "AC198", "Reox", "A", "60", "A.Reox", "60.Reox", "0.881293587402" ], [ "57", "AC198Pp", "AC198", "Reox", "Pp", "60", "Pp.Reox", "60.Reox", "0.986087524832312" ], [ "58", "AC199A", "AC199", "Hyp_T2h", "A", "71", "A.Hyp_T2h", "71.Hyp_T2h", "1.18506580354224" ], [ "59", "AC199Pp", "AC199", "Hyp_T2h", "Pp", "71", "Pp.Hyp_T2h", "71.Hyp_T2h", "1.03680502689986" ], [ "60", "AC200A", "AC200", "Hyp_T2h", "A", "71", "A.Hyp_T2h", "71.Hyp_T2h", "1.42318508544718" ], [ "61", "AC200Pp", "AC200", "Hyp_T2h", "Pp", "71", "Pp.Hyp_T2h", "71.Hyp_T2h", "1.23650128887904" ], [ "62", "AC201A", "AC201", "Hyp_T2h", "A", "71", "A.Hyp_T2h", "71.Hyp_T2h", "1.53573191666016" ], [ "63", "AC201Pp", "AC201", "Hyp_T2h", "Pp", "71", "Pp.Hyp_T2h", "71.Hyp_T2h", "0.965158174217358" ], [ "64", "AC202A", "AC202", "Hyp_T6h", "A", "71", "A.Hyp_T6h", "71.Hyp_T6h", "1.14482620757086" ], [ "65", "AC202Pp", "AC202", "Hyp_T6h", "Pp", "71", "Pp.Hyp_T6h", "71.Hyp_T6h", "1.24697560909873" ], [ "66", "AC203A", "AC203", "Hyp_T6h", "A", "71", "A.Hyp_T6h", "71.Hyp_T6h", "1.04716127615624" ], [ "67", "AC203Pp", "AC203", "Hyp_T6h", "Pp", "71", "Pp.Hyp_T6h", "71.Hyp_T6h", "0.926064407993533" ], [ "68", "AC204A", "AC204", "Hyp_T6h", "A", "71", "A.Hyp_T6h", "71.Hyp_T6h", "0.982818454591424" ], [ "69", "AC204Pp", "AC204", "Hyp_T6h", "Pp", "71", "Pp.Hyp_T6h", "71.Hyp_T6h", "1.43951575339789" ], [ "70", "AC205A", "AC205", "Recovery", "A", "71", "A.Recovery", "71.Recovery", "0.834579243308049" ], [ "71", "AC205Pp", "AC205", "Recovery", "Pp", "71", "Pp.Recovery", "71.Recovery", "1.07628296331374" ], [ "72", "AC206A", "AC206", "Recovery", "A", "71", "A.Recovery", "71.Recovery", "1.05966480696276" ], [ "73", "AC206Pp", "AC206", "Recovery", "Pp", "71", "Pp.Recovery", "71.Recovery", "0.909059918872948" ], [ "74", "AC207A", "AC207", "Recovery", "A", "71", "A.Recovery", "71.Recovery", "0.936499822989513" ], [ "75", "AC207Pp", "AC207", "Recovery", "Pp", "71", "Pp.Recovery", "71.Recovery", "0.869333380803847" ], [ "76", "AC208A", "AC208", "Reox", "A", "71", "A.Reox", "71.Reox", "0.93383746355589" ], [ "77", "AC208Pp", "AC208", "Reox", "Pp", "71", "Pp.Reox", "71.Reox", "1.1025240683002" ], [ "78", "AC209A", "AC209", "Reox", "A", "71", "A.Reox", "71.Reox", "0.782111293073387" ], [ "79", "AC209Pp", "AC209", "Reox", "Pp", "71", "Pp.Reox", "71.Reox", "1.11940659608226" ], [ "80", "AC210A", "AC210", "Reox", "A", "71", "A.Reox", "71.Reox", "1.14617900706068" ] ];
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
