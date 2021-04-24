HA$PBExportHeader$w_misth_final_search.srw
$PBExportComments$
forward
global type w_misth_final_search from w_searchex
end type
type uo_datefinal from u_dates within w_misth_final_search
end type
end forward

global type w_misth_final_search from w_searchex
integer width = 2080
integer height = 952
string icon = "res\final.ico"
uo_datefinal uo_datefinal
end type
global w_misth_final_search w_misth_final_search

forward prototypes
protected function string of_createwhere ()
end prototypes

protected function string of_createwhere ();string	ls_where

string	lstring
long		llong	
date		ldate
time		ltime
integer	li_hour, li_minute
double	ldouble

// aa
	llong = dw.object.aa[1]
	if not isnull(llong) then
		ls_where = ls_where + " AND misth_final.aa = " + string(llong)
	end if
	
// kodperiod
	lstring = dw.object.kodperiod[1]
	if not isnull(lstring) and lstring <> "" then
		ls_where = ls_where + " AND misth_final.kodperiod = ~~'" + lstring + "~~'"
	end if	

// kodkat
	lstring = dw.object.kodkat[1]
	if not isnull(lstring) and lstring <> "" then
		ls_where = ls_where + " AND misth_final.kodkat = ~~'" + lstring + "~~'"
	end if

// descfinal
	lstring = dw.object.descfinal[1]
	if not isnull(lstring) and lstring <> "" then
		ls_where = ls_where + " AND descfinal LIKE ~~'" + lstring + "%~~'"
	end if
	
// datefinal - from
	ldate = uo_datefinal.uf_getdatefrom()
	if not isnull(ldate) then
		ls_where = ls_where + " AND misth_final.datefinal >= ~~'" + fn_date2string(ldate) + "~~'"
	end if	
	
// datefinal - to
	ldate = uo_datefinal.uf_getdateto()
	if not isnull(ldate) then
		ls_where = ls_where + " AND misth_final.datefinal <= ~~'" + fn_date2string(ldate) + "~~'"
	end if	
	
	
return ls_where



end function

on w_misth_final_search.create
int iCurrent
call super::create
this.uo_datefinal=create uo_datefinal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_datefinal
end on

on w_misth_final_search.destroy
call super::destroy
destroy(this.uo_datefinal)
end on

event open;call super::open;fn_retrievechild(dw, "kodperiod", gs_kodxrisi)
fn_retrievechild(dw, "kodkat", gs_kodxrisi)

// set captions
	uo_datefinal.uf_setcaption(trn(366))
	
// translation
	title = trn(71)
	
end event

type cb_cancel from w_searchex`cb_cancel within w_misth_final_search
integer x = 1673
integer y = 716
end type

type cb_ok from w_searchex`cb_ok within w_misth_final_search
integer x = 1335
integer y = 716
end type

type dw from w_searchex`dw within w_misth_final_search
integer width = 1989
integer height = 404
string dataobject = "dw_misth_final_search"
end type

type uo_datefinal from u_dates within w_misth_final_search
integer x = 55
integer y = 452
integer taborder = 40
boolean bringtotop = true
end type

on uo_datefinal.destroy
call u_dates::destroy
end on

