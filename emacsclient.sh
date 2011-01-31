#!/bin/sh

if ! which wmctrl > /dev/null 2>&1
then
    echo "Please install wmctrl"
    exit 1
fi

# get current window id
CURRENT_WID=`wmctrl -a :ACTIVE: -v 2>&1 | \
    perl -wln -e 'm{Using window: (\w+)$} and print $1'` 2> /dev/null
if [ "$CURRENT_WID" = "" ]
then
    echo "Faild getting current window id"
    exit 1
fi

WID_FILE=${HOME}/.emacs.d/server_wid

if [ -e $WID_FILE ]
then
    # server is running on GUI Emacs
    WID=`cat $WID_FILE`
    # forcus emacs server window
    wmctrl -i -a $WID
else
    # server is running emacs in terminal
    SERVER_TERM_TITLE='emacsserver_run'
    wmctrl -F -a $SERVER_TERM_TITLE
fi

emacsclient $@

# return to origin window
wmctrl -i -a $CURRENT_WID
