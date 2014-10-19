(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* :Title: DocumentationMaker *) 
(* :Author: jmlopez *)
(* :Email: jmlopez.rod@gmail.com *)
(* :Summary: Provides functions to create guides, tutorials and reference pages. *)
(* :Context: ApplicationMaker`DocumentationMaker` *)
(* :Package version: 1.0 *)
(* :History:  Version 1.0 July 10 2011 *)
(* :Mathematica version: 8.0 for Mac OS X x86 (64-bit) (February 23, 2011) *)


BeginPackage["ApplicationMaker`DocumentationMaker`"];


Unprotect[ViewOption,EditOption, ViewNotebookOption, EditNotebookOption, NewGuide, NewTutorial, CreateReferencePages];
ClearAll[ViewOption,EditOption, ViewNotebookOption, EditNotebookOption, NewGuide, NewTutorial, CreateReferencePages];


(* :Usage Messages: *)


ViewOption::usage =
"ViewOption[\!\(\*
StyleBox[\"obj\", \"TI\"]\), \!\(\*
StyleBox[\"name\", \"TI\"]\)] inserts an input cell in the evaluation notebook displaying the settings for the option \!\(\*
StyleBox[\"name\", \"TI\"]\)";
EditOption::usage =
"EditOption[\!\(\*
StyleBox[\"obj\", \"TI\"]\), \!\(\*
StyleBox[\"name\", \"TI\"]\), \!\(\*
StyleBox[\"objStr\", \"TI\"]\)] inserts an input cell in the evaluation notebook with the expression required to change the settings of the option \!\(\*
StyleBox[\"name\", \"TI\"]\).";
ViewNotebookOption::usage =
"ViewNotebookOption[\!\(\*
StyleBox[\"name\", \"TI\"]\)] inserts an input cell in the evaluation notebook displaying the settings for the option \!\(\*
StyleBox[\"name\", \"TI\"]\).";
EditNotebookOption::usage =
"EditNotebookOption[\!\(\*
StyleBox[\"name\", \"TI\"]\)] inserts an input cell in the evaluation notebook with the expression required to change the settings of the option \!\(\*
StyleBox[\"name\", \"TI\"]\).";
NewGuide::usage =
"NewGuide[\!\(\*
StyleBox[\"guideName\", \"TI\"]\), \!\(\*
StyleBox[\"appName\", \"TI\"]\)] creates the guide notebook \!\(\*
StyleBox[\"guideName\", \"TI\"]\)\!\(\*
StyleBox[\".\", \"TI\"]\)\!\(\*
StyleBox[\"nb\", \"TI\"]\) inside the documentation for the application \!\(\*
StyleBox[\"appName\", \"TI\"]\).";
NewTutorial::usage =
"NewTutorial[\!\(\*
StyleBox[\"tutName\", \"TI\"]\), \!\(\*
StyleBox[\"appName\", \"TI\"]\)] creates the tutorial notebook \!\(\*
StyleBox[\"tutName\", \"TI\"]\)\!\(\*
StyleBox[\".\", \"TI\"]\)\!\(\*
StyleBox[\"nb\", \"TI\"]\) inside the documentation for the application \!\(\*
StyleBox[\"appName\", \"TI\"]\).";
CreateReferencePages::usage = 
"CreateReferencePages[\!\(\*
StyleBox[\"appName\", \"TI\"]\)] creates references pages for each symbol in the application \!\(\*
StyleBox[\"appName\", \"TI\"]\).";


(* :Error Messages: *)


ViewOption::argerr =
"An object and a String representing the option name were excepted.";
EditOption::argerr =
"An object, a String representing the option name and the string version of the object were excepted.";
ViewNotebookOption::argerr =
"A String representing the option name was excepted.";
EditNotebookOption::argerr =
"A String representing the option name was excepted.";
NewGuide::argerr=
"Strings specifying the guide name and the application it belongs to were expected.";
NewGuide::nodir =
"There is no application `1` in `2`. To create a new application use NewApplication";
NewGuide::guideerr = 
"The guide you are trying to create in the application `1` already exists. Click `2` to edit its contents.";
NewTutorial::argerr=
"Strings specifying the guide name and the application it belongs to were expected.";
NewTutorial::nodir =
"There is no application `1` in `2`. To create a new application use NewApplication";
NewTutorial::tuterr = 
"The guide you are trying to create in the application `1` already exists. Click `2` to edit its contents.";
CreateReferencePages::argerr=
"A string specifying the application name was expected.";
CreateReferencePages::nodir =
"There is no application `1` in `2`. To create a new application use NewApplication";
CreateReferencePages::symb = 
"A reference page for `1` already exists. Click `2` to make changes.";


Begin["`Private`"];


ClearAll[RuleToString, QuoteList];
QuoteList[str_] :=Module[{nl, newstr=""},
If[MatchQ[str, _String],Return@StringJoin["\"", str, "\""]];
If[!MatchQ[str, _List], Return@ToString[str]];
nl = "\[IndentingNewLine]";
newstr = StringJoin[newstr, "{", nl];
Do[
If[MatchQ[str[[i]], _Rule], 
newstr = StringJoin[newstr, RuleToString[str[[i]]],",", nl ],
newstr = StringJoin[newstr, QuoteList@str[[i]], ",",nl ]
];
,{i, Length@str-1}];
If[MatchQ[str[[Length@str]], _Rule], 
newstr = StringJoin[newstr, RuleToString[str[[Length@str]]], nl ],
newstr = StringJoin[newstr, QuoteList@str[[Length@str]], nl ]
];
newstr = StringJoin[newstr, "}"];
Return@newstr;
]
RuleToString[rule_Rule] := Module[
{str = "", opname, val, nl},
nl = "\[IndentingNewLine]";
opname=rule[[1]];
val = rule[[2]];
If[!MatchQ[val, _List],
str = StringJoin[str, QuoteList@opname," \[Rule] ",QuoteList@val];
Return[str];
];
str = StringJoin[str, QuoteList@opname, " \[Rule] {", nl];
Do[
If[MatchQ[val[[i]], _Rule], 
str = StringJoin[str, RuleToString[val[[i]]],",", nl ],
str = StringJoin[str, QuoteList[val[[i]]],",",  nl ];
];
,{i, Length@val-1}
];
If[MatchQ[val[[Length@val]], _Rule], 
str = StringJoin[str, RuleToString[val[[Length@val]]], nl ],
str = StringJoin[str, QuoteList@val[[Length@val]], nl ];
];
str = StringJoin[str, "}"];
Return[str];
]


ViewOption[args___] := (Message[ViewOption::argerr];$Failed)
ViewOption[
obj_, name_String
] := Module[
{opt,str="", nl},
opt = Options[obj, name];
If[opt == {}, Return[$Failed], opt = First@opt];
nl = "\[IndentingNewLine]";
str = StringJoin[str, RuleToString[opt], nl];
NotebookWrite[EvaluationNotebook[], 
Cell[BoxData[RowBox[{StyleBox[str, "MSG"]}]], "Input"]
];
]


EditOption[args___] := (Message[EditOption::argerr];$Failed)
EditOption[
obj_, name_String, o_String
] := Module[
{opt,str, nl},
opt = Options[obj, name];
If[opt == {}, Return[$Failed], opt = First@opt];
nl = "\[IndentingNewLine]";
str = StringJoin["SetOptions[", o, ", ", nl];
str = StringJoin[str, RuleToString[opt], nl];
str = StringJoin[str, "]"];
NotebookWrite[EvaluationNotebook[], 
Cell[BoxData[RowBox[{str}]], "Input"]
];
]


ViewNotebookOption[args___] := (Message[ViewNotebookOption::argerr];$Failed)
ViewNotebookOption[name_String, nbo_: HoldForm[SelectedNotebook[]]] := Module[{nb},
nb = ReleaseHold[nbo];
If[!MatchQ[nb,_NotebookObject], Message[ViewNotebookOption::argerr]; Return[$Failed]];
ViewOption[nb, name];
]


EditNotebookOption[args___] := (Message[EditNotebookOption::argerr];$Failed)
EditNotebookOption[name_String, nbo_:HoldForm[SelectedNotebook[]],nbs_String:"EvaluationNotebook[]"] :=Module[{nb},
nb = ReleaseHold[nbo];
If[!MatchQ[nb,_NotebookObject], Message[EditNotebookOption::argerr]; Return[$Failed]];
 EditOption[nb, name, nbs];
]


NewGuide[args___] := (Message[NewGuide::argerr];$Failed)
NewGuide[guideName_String, appName_String,
appDir_String: FileNameJoin[{ $UserBaseDirectory,"Applications"}]
] := Module[
{appNameDir, guidePath, nb},
appNameDir =  FileNameJoin[{appDir, appName}];
If[!DirectoryQ[appNameDir], Message[NewGuide::nodir, appName, appDir]; Return[$Failed]];
guidePath = FileNameJoin[
{appNameDir,"Documentation", "English","Guides",StringJoin["___", guideName,".nb"] }
];
If[FileExistsQ[guidePath],
Message[NewGuide::guideerr, appName, Hyperlink["here", guidePath]]; 
Return[$Failed]
];
nb = CreateDocument[];

SetOptions[nb, 
StyleDefinitions-> FileNameJoin[{appDir, "ApplicationMaker","FrontEnd", "Stylesheets", "UserReference"<>ToString[Floor[$VersionNumber]] <>".nb"}],
DockedCells-> None,
WindowTitle -> guideName<>" - "<>appName,
TaggingRules-> {
"ModificationHighlight"->False,
"Metadata"->{
"context"->appName<>"`",
"keywords"->{ToLowerCase[guideName], ToUpperCase[guideName]},
"index"->True,
"label"->appName<>" Guide",
"language"->"en",
"paclet"->appName,
"status"->"",
"summary"-> "This summary was generated by ApplicationMaker`DocumentationMaker`NewGuide.",
"synonyms"->{ToLowerCase[guideName], ToUpperCase[guideName]},
"title"->guideName,
"windowTitle" -> guideName,
"type"->"Guide",
"uri"->appName<>"/guide/"<>guideName
},
"SearchTextTranslated"->""
}
];
NotebookWrite[nb, 
Cell[
BoxData[
GridBox[{{Cell[ToUpperCase[appName]<>" GUIDE","PacletNameCell"],
Cell[TextData[{
Cell[BoxData[ActionMenuBox[FrameBox["\<\"Tutorials \[RightGuillemet]\"\>",StripOnInput->False],{
"\<\"Title of tutorial 1\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/tutorial/tutorialName1"],
"\<\"Title of tutorial 2\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/tutorial/tutorialName2"]
},
Appearance->None,MenuAppearance->Automatic]
],
LineSpacing->{1.4,0}],"\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]",
Cell[BoxData[ActionMenuBox[FrameBox["\<\"URL \[RightGuillemet]\"\>",StripOnInput->False],{
"\<\"Go to "<>appName<>"/tutorial/"<>guideName<>" URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["your.website.goes.here/documentationIfAny"],None}]
}],
Delimiter,
"\<\"Go to wolfram URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["http://reference.wolfram.com/mathematica/guide/Mathematica.html"],None}]
}],
"\<\"Go to authors URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["your.website.goes.here"],None}]
}]
},
Appearance->None,MenuAppearance->Automatic]
],
LineSpacing->{1.4,0}
]}],"AnchorBar"]}}]],
"AnchorBarGrid"]
];
NotebookWrite[nb, Cell["Guide title.", "GuideTitle"]];
NotebookWrite[nb, Cell["This is a template for a guide document. A lot of functions usually go after this guide abstract. To edit the hyperlinks you can click on the cell that contains the link and press cmd+E on a Mac or ctr+E on a windows system. Edit the link and then revert the process by pressing the same sequence of keys.", "GuideAbstract"]];
NotebookWrite[nb,
Cell[TextData[ButtonBox["Package Title \[RightGuillemet]",BaseStyle->{"Link","GuideFunctionsSubsection"},ButtonData->"paclet:"<>appName<>"/guide/SomeOtherGuide"]],"GuideFunctionsSubsection"]
];
NotebookWrite[nb,
Cell[TextData[{
Cell[TextData[ButtonBox["FunctionName",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/ref/FunctionName"]],"InlineFunctionSans"]," ",StyleBox["\[LongDash]","GuideEmDash"]," ","Description"
}],"GuideText"
]
];
NotebookWrite[nb,
Cell[TextData[{
Cell[TextData[ButtonBox["Function1",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/ref/Function1"]],"InlineFunctionSans"],
"\[NonBreakingSpace]",StyleBox["\[MediumSpace]\[FilledVerySmallSquare]\[MediumSpace]","InlineSeparator"]," ",Cell[TextData[ButtonBox["Function2",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/ref/Function2"]],"InlineFunctionSans"],
"\[NonBreakingSpace]",StyleBox["\[MediumSpace]\[FilledVerySmallSquare]\[MediumSpace]","InlineSeparator"]," ",Cell[TextData[ButtonBox["Function3",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/ref/Function3"]],"InlineFunctionSans"],
"\[NonBreakingSpace]",StyleBox["\[MediumSpace]\[FilledVerySmallSquare]\[MediumSpace]","InlineSeparator"]," ",Cell[TextData[ButtonBox["...",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/guide/SomeOtherGuide"]],"InlineFunctionSans"]}],"InlineGuideFunctionListing"]
];
NotebookWrite[nb, Cell["TUTORIALS", "TutorialsSection", WholeCellGroupOpener-> True]];
NotebookWrite[nb,
 Cell[TextData[{
StyleBox[ButtonBox["SomeTutorial",BaseStyle->"Link",ButtonData->"paclet:""/tutorial/Overview"]]
}],"RelatedTutorials"]
];
NotebookWrite[nb, Cell[" ","FooterCell"]];
NotebookSave[nb, guidePath];
Return[nb];
]


NewTutorial[args___] := (Message[NewTutorial::argerr];$Failed)
NewTutorial[tutName_String, appName_String,
appDir_String: FileNameJoin[{ $UserBaseDirectory,"Applications"}]
] := Module[
{appNameDir, tutPath, nb},
appNameDir =  FileNameJoin[{appDir, appName}];
If[!DirectoryQ[appNameDir], Message[NewTutorial::nodir, appName, appDir]; Return[$Failed]];
tutPath = FileNameJoin[
{appNameDir,"Documentation", "English","Tutorials",StringJoin["___", tutName,".nb"] }
];
If[FileExistsQ[tutPath],
Message[NewTutorial::tuterr, appName, Hyperlink["here", tutPath]]; 
Return[$Failed]
];
nb = CreateDocument[];
SetOptions[nb, 
StyleDefinitions-> FileNameJoin[{appDir, "ApplicationMaker","FrontEnd", "Stylesheets", "UserReference"<>".nb"}],
DockedCells-> None,
WindowTitle -> tutName<>" - "<>appName,
TaggingRules-> {
"ModificationHighlight"->False,
"Metadata"->{
"context"->appName<>"`",
"keywords"->{ToLowerCase[tutName], ToUpperCase[tutName]},
"index"->True,
"label"->appName<>" Guide",
"language"->"en",
"paclet"->appName,
"status"->"",
"summary"-> "This summary was generated by ApplicationMaker`DocumentationMaker`NewTutorial.",
"synonyms"->{ToLowerCase[tutName], ToUpperCase[tutName]},
"title"->tutName,
"windowTitle" -> tutName,
"type"->"Guide",
"uri"->appName<>"/tutorial/"<>tutName
},
"SearchTextTranslated"->""
}
];
NotebookWrite[nb, 
Cell[
BoxData[GridBox[{{Cell[ToUpperCase[appName]<>" TUTORIAL","PacletNameCell"],
Cell[TextData[{
Cell[BoxData[ActionMenuBox[FrameBox["\<\"Related Tutorials \[RightGuillemet]\"\>",StripOnInput->False],{
"\<\"Title of tutorial 1\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/tutorial/tutorialName1"],
"\<\"Title of tutorial 2\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/tutorial/tutorialName2"]
},
Appearance->None,MenuAppearance->Automatic]
],
LineSpacing->{1.4,0}],"\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]",
Cell[BoxData[ActionMenuBox[FrameBox["\<\"URL \[RightGuillemet]\"\>",StripOnInput->False],{
"\<\"Go to "<>appName<>"/tutorial/"<>tutName<>" URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["your.website.goes.here/documentationIfAny"],None}]
}],
Delimiter,
"\<\"Go to wolfram URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["http://reference.wolfram.com/mathematica/guide/Mathematica.html"],None}]
}],
"\<\"Go to authors URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["your.website.goes.here"],None}]
}]
},
Appearance->None,MenuAppearance->Automatic]
],
LineSpacing->{1.4,0}
]}],"AnchorBar"]}}]],"AnchorBarGrid"]
];
NotebookWrite[nb, Cell["Tutorial Title", "Title"]];
NotebookWrite[nb, Cell["This is a template for a tutorial document. To get more ideas on how to make a tutorial page look at other tutorial pages and copy and paste the cells they contain for a quick template.", "Text"]];
NotebookWrite[nb, Cell["Tutorial Section", "Section"]];
NotebookWrite[nb, Cell["RELATED TUTORIALS", "RelatedTutorialsSection", WholeCellGroupOpener-> True]];
NotebookWrite[nb,
 Cell[TextData[{
StyleBox[ButtonBox["SomeTutorial",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/tutorial/Overview"]]
}],"RelatedTutorials"]
];
NotebookWrite[nb, Cell[" ","FooterCell"]];
NotebookSave[nb, tutPath];
Return[nb];
]


CreateReferencePages[args___] := (Message[CreateReferencePages::argerr];$Failed)
CreateReferencePages[appName_String,
appDir_String: FileNameJoin[{ $UserBaseDirectory,"Applications"}]
] := Module[
{appNameDir, symDir, refPath, pkg, sym, nb, str},
Get[appName<>"`"];
Off[General::stop];
appNameDir =  FileNameJoin[{appDir, appName}];
symDir = FileNameJoin[
{appNameDir,"Documentation", "English","ReferencePages", "Symbols" }
];
If[!DirectoryQ[appNameDir], Message[CreateReferencePages::nodir, appName, appDir]; Return[$Failed]];
pkg = Map[FileBaseName, FileNames[appNameDir<>"/*.nb"]];
Do[
Print[Style["Building reference pages for: ", "MSG"],Style[pkg[[i]], "Input"]];
sym = Names[StringJoin[appName, "`", pkg[[i]], "`*"]];
Do[
refPath = FileNameJoin[{symDir, StringJoin["___",sym[[j]],".nb"]}];
If[FileExistsQ[refPath], Message[CreateReferencePages::symb, sym[[j]],  Hyperlink["here", refPath]],
nb = CreateDocument[];
SetOptions[nb,
StyleDefinitions-> FileNameJoin[
{appDir, "ApplicationMaker","FrontEnd", "Stylesheets", "UserReference"<>".nb"}
],
DockedCells-> None,
WindowTitle -> sym[[j]]<>" - "<>appName<>"`"<>pkg[[i]]<>"`",
TaggingRules-> {
"ModificationHighlight"->False,
"Metadata"->{
"context"->appName<>"`",
"keywords"->{ToLowerCase[sym[[j]]], ToUpperCase[sym[[j]]]},
"index"->True,
"label"->appName<>"`"<>pkg[[i]]<>"` Symbol",
"language"->"en",
"paclet"->appName<>" "<>pkg[[i]],
"status"->"",
"summary"-> ToExpression[sym[[j]]<>"::usage"],
"synonyms"->{ToLowerCase[sym[[j]]], ToUpperCase[sym[[j]]]},
"title"->sym[[j]],
"windowTitle" -> sym[[j]],
"type"->"Symbol",
"uri"->appName<>"/ref/"<>sym[[j]]
},
"SearchTextTranslated"->""
}
];
NotebookWrite[nb, 
Cell[
BoxData[GridBox[{{Cell[ToUpperCase[appName<>"`"<>pkg[[i]]<>"`"]<>" SYMBOL","PacletNameCell"],
Cell[TextData[{
Cell[BoxData[ActionMenuBox[FrameBox["\<\"Tutorials \[RightGuillemet]\"\>",StripOnInput->False],{
"\<\"Title of tutorial 1\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/tutorial/tutorialName1"],
"\<\"Title of tutorial 2\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/tutorial/tutorialName2"]
},
Appearance->None,MenuAppearance->Automatic]
],
LineSpacing->{1.4,0}],"\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]",
Cell[BoxData[ActionMenuBox[FrameBox["\<\"See Also \[RightGuillemet]\"\>",StripOnInput->False],{
"\<\"Symbol1\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/ref/Symbol1"],
"\<\"Symbol2\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/ref/Symbol2"]
},Appearance->None,MenuAppearance->Automatic]
],
LineSpacing->{1.4,0}],"\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]",
Cell[BoxData[ActionMenuBox[FrameBox["\<\"More About \[RightGuillemet]\"\>",StripOnInput->False],{
"\<\"Guide 1\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/guide/Guide1"],
"\<\"Guide 2\"\>":>Documentation`HelpLookup["paclet:"<>appName<>"/guide/Guide2"]
},Appearance->None,MenuAppearance->Automatic]
],
LineSpacing->{1.4,0}],"\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]\[ThickSpace]",
Cell[BoxData[ActionMenuBox[FrameBox["\<\"URL \[RightGuillemet]\"\>",StripOnInput->False],{
"\<\"Go to "<>appName<>"/ref/"<>sym[[j]]<>" URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["your.website.goes.here/documentationIfAny"],None}]
}],
Delimiter,
"\<\"Go to wolfram URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["http://reference.wolfram.com/mathematica/guide/Mathematica.html"],None}]
}],
"\<\"Go to authors URL\"\>":>FrontEndExecute[{
NotebookLocate[{URL["your.website.goes.here"],None}]
}]
},
Appearance->None,MenuAppearance->Automatic]
],
LineSpacing->{1.4,0}
]}],"AnchorBar"]}}]],"AnchorBarGrid"]
];
NotebookWrite[nb, Cell[sym[[j]], "ObjectName"]];
NotebookWrite[nb, Cell[BoxData[GridBox[{
{"",
Cell[TextData[{
Cell[BoxData[RowBox[{
ButtonBox[sym[[j]],BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/ref/"<>sym[[j]]],"[",StyleBox["args","TI"],"]"
}]
],"InlineFormula"],"\[LineSeparator]"<> ToExpression[sym[[j]]<>"::usage"]}]]
}
}]], "Usage"]
];
(*MORE INFO*)
NotebookWrite[nb,
Cell[TextData[Cell[BoxData[
ButtonBox[
FrameBox[
StyleBox[
RowBox[{"MORE", " ", "INFORMATION"}], "NotesFrameText"],
StripOnInput-> False],
Appearance->{Automatic, None},
BaseStyle-> None,
ButtonFunction:> (FrontEndExecute[{
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], All, ButtonCell],
FrontEndToken["OpenCloseGroup"],
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], After, CellContents]}]& ),
Evaluator-> None,
Method-> "Preemptive"]]]], "NotesSection",
WholeCellGroupOpener-> True,
CellGroupingRules-> {"SectionGrouping", 50}
]
];
NotebookWrite[nb,
Cell["\<Note about the function goes here.\>","Notes"]
];
NotebookWrite[nb,
Cell["\<Another Note about the function goes here.\>","Notes"]
];
(*PRIMARY EXAMPLES*)
NotebookWrite[nb,
Cell[TextData[ButtonBox["EXAMPLES",
BaseStyle-> None,
Appearance->{Automatic, None},
Evaluator-> None,
Method-> "Preemptive",
ButtonFunction:> (FrontEndExecute[{
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], All, ButtonCell],
FrontEndToken["OpenCloseGroup"],
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], After, CellContents]}]& )]], "PrimaryExamplesSection",
WholeCellGroupOpener-> True,
CellTags-> "PrimaryExamplesSection"]
];
NotebookWrite[nb,
Cell[TextData[{
"Basic Examples",
"\[NonBreakingSpace]\[NonBreakingSpace]", Cell["(#)", "ExampleCount"]
}], "ExampleSection", "ExampleSection", WholeCellGroupOpener-> True]
];
NotebookWrite[nb,
Cell["Use the ExampleText style to write cells like this one.","ExampleText"]
];
NotebookWrite[nb,
Cell[BoxData[
InterpretationBox[Cell[TextData[{
"Scope",
"  ", Cell["(#)", "ExampleCount"]
}], "ExampleSection"],
$Line=0; Null]], "ExampleSection", "ExampleSection",
WholeCellGroupOpener-> True]
];
NotebookWrite[nb,
Cell["Use the ExampleText style to write cells like this one.","ExampleText"]
];
(*SEE ALSO*)
NotebookWrite[nb,
Cell[TextData[ButtonBox["SEE ALSO",
BaseStyle-> None,
Appearance->{Automatic, None},
Evaluator-> None,
Method-> "Preemptive",
ButtonFunction:> (FrontEndExecute[{
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], All, ButtonCell],
FrontEndToken["OpenCloseGroup"],
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], After, CellContents]}]& )]], "SeeAlsoSection",
WholeCellGroupOpener-> True]
];
NotebookWrite[nb,
Cell[TextData[{
Cell[BoxData[StyleBox[
ButtonBox["SymbolOne",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/ref/SymbolOne"],
FontFamily->"Verdana"]],"InlineFormula"],
"\[NonBreakingSpace]",StyleBox["\[MediumSpace]\[FilledVerySmallSquare]\[MediumSpace]","InlineSeparator"]," ",Cell[BoxData[StyleBox[
ButtonBox["SymbolTwo",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/ref/SymbolTwo"],
FontFamily->"Verdana"]],"InlineFormula"]
}], 
"SeeAlso"]
];
(*TUTORIALS*)
NotebookWrite[nb,
Cell[TextData[ButtonBox["TUTORIALS",
BaseStyle-> None,
Appearance->{Automatic, None},
Evaluator-> None,
Method-> "Preemptive",
ButtonFunction:> (FrontEndExecute[{
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], All, ButtonCell],
FrontEndToken["OpenCloseGroup"],
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], After, CellContents]}]& )]], "TutorialsSection",
WholeCellGroupOpener-> True]
];
str = "paclet:"<>appName<>"/tutorial/tutorial1";
NotebookWrite[nb,
Cell[TextData[ButtonBox["Tutorial Title 1",BaseStyle->"Link",ButtonData->str]],"Tutorials"]
];
str = "paclet:"<>appName<>"/tutorial/tutorial2";
NotebookWrite[nb,
Cell[TextData[ButtonBox["Tutorial Title 2",BaseStyle->"Link",ButtonData->str]],"Tutorials"]
];
(*MORE ABOUT*)
NotebookWrite[nb,
Cell[TextData[ButtonBox["MORE ABOUT",
BaseStyle-> None,
Appearance->{Automatic, None},
Evaluator-> None,
Method-> "Preemptive",
ButtonFunction:> (FrontEndExecute[{
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], All, ButtonCell],
FrontEndToken["OpenCloseGroup"],
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], After, CellContents]}]& )]], "MoreAboutSection",
WholeCellGroupOpener-> True]
];
NotebookWrite[nb,
Cell[TextData[ButtonBox["Title of Guide 1",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/guide/Guide1"]],"MoreAbout"]
];
NotebookWrite[nb,
Cell[TextData[ButtonBox["Title of Guide 2",BaseStyle->"Link",ButtonData->"paclet:"<>appName<>"/guide/Guide2"]],"MoreAbout"]
];
(*RELATED LINKS*)
NotebookWrite[nb,
Cell[TextData[ButtonBox["RELATED LINKS",
BaseStyle-> None,
Appearance->{Automatic, None},
Evaluator-> None,
Method-> "Preemptive",
ButtonFunction:> (FrontEndExecute[{
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], All, ButtonCell],
FrontEndToken["OpenCloseGroup"],
FrontEnd`SelectionMove[
FrontEnd`SelectedNotebook[], After, CellContents]}]& )]], "RelatedLinksSection",
WholeCellGroupOpener-> True]
];
NotebookWrite[nb,
Cell[TextData[ButtonBox["Link Title 1",BaseStyle->"Hyperlink",ButtonData->{URL["URL.goes.here"],None}]],"RelatedLinks"]
];
NotebookWrite[nb,
Cell[TextData[ButtonBox["Link Title 2",BaseStyle->"Hyperlink",ButtonData->{URL["URL.goes.here"],None}]],"RelatedLinks"]
];
NotebookWrite[nb,
Cell["Made for Mathematica 8  |  Last modified in "<>DateString[{"MonthName", " ", "Year"}],"History"]
];
NotebookWrite[nb,
Cell[" ","FooterCell"]
];
NotebookSave[nb,refPath];
];
,{j, Length@sym}]
,{i, Length@pkg}];
On[General::stop];
]


End[];


Protect[ViewOption,EditOption, ViewNotebookOption, EditNotebookOption, NewGuide, NewTutorial, CreateReferencePages];


EndPackage[];