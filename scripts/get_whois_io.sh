#!/bin/bash
TARGET="click.to";
WHOISSRV="https://www.tonic.to";
MAINDIR=/tmp;
METRICS=domain_expire_day.prom;

bashdays_box() {
    local headertext="$1"
    local message="$2"

    local white=$'\e[38;5;007m'
    local reset=$'\e[0m'
    local color

    case "$headertext" in
        INFO)  color=$'\e[38;5;39m' ;;
        OK)    color=$'\e[38;5;34m' ;;
        DONE)  color=$'\e[38;5;34m' ;;
        WARN)  color=$'\e[38;5;214m' ;;
        ERROR) color=$'\e[38;5;196m' ;;
        DEBUG) color=$'\e[38;5;244m' ;;
        TASK)  color=$'\e[38;5;141m' ;;
        NOTE)  color=$'\e[38;5;45m' ;;
        *)     color=$'\e[38;5;244m' ;;
    esac

    local headerpadding=$(( ${#message} - ${#headertext} ))
    local header=${message:0:headerpadding}

    echo -e "\n${color}╭ ${headertext} ${header//?/─}────╮" \
                    "\n│   ${message//?/ }   │"             \
                    "\n│   ${white}${message}${color}   │"  \
                    "\n│   ${message//?/ }   │"             \
                    "\n╰──${message//?/─}────╯${reset}"
}

EXPIRATIONDATE=$(curl $WHOISSRV"/whois?"$TARGET -s | grep "Expires on:" | awk '{print $3, $4,$5,$7,$6}'); 

bashdays_box "NOTE" " Today : $(date +%s) = $(date) "

EXPSEC="$(date -d "$EXPIRATIONDATE" '+%s')"

color=$'\e[38;5;34m';
echo -e "${color} Domain for check:" ${TARGET}
bashdays_box "INFO" "$EXPSEC  = $EXPIRATIONDATE"

# EXPSEC=$((($EXPIRATIONDATE) - $(date +%s)));
# DELTA=$((($(date -d "$EXPIRATIONDATE" '+%s') - $(date +%s))  ));
# echo $DELTA
echo $EXPSEC
echo "domain_expire_day{domain=\"$TARGET\"} $EXPSEC" | sed 's/null/0/' > $MAINDIR/$METRICS