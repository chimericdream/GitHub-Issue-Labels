#!/bin/bash
USER="";
PASS="";
REPO="";
REPO_USER="";
REPO_NAME="";

rmdefaults_yn="n";
app_type="";
thirdparty_yn="n";
app_language="";

## Build dependencies
grunt_yn="n";
gulp_yn="n";
make_yn="n";
nodenpm_yn="n";

## Front end frameworks
angular_yn="n";
bootstrap_yn="n";
bower_yn="n";
jquery_yn="n";
react_yn="n";

## PHP frameworks
composer_yn="n";
drupal_yn="n";
symfony_yn="n";
wordpress_yn="n";
zend_yn="n";

function init() {
    echo -e "\033[00;36;40m================================================================";
    echo -e "This script is intended to help set up labels on GitHub repositories. It adds a";
    echo -e "common set of labels for repositories and can be configured on the fly to set up";
    echo -e "labels specific to various types of applications. Simply follow the prompts";
    echo -e "below, and your repository's labels will be configured for you.";

    echo -e "\n\033[01;36;40m## GitHub Settings ##\033[00;36;40m";

    echo -ne "\033[00;37;40mGitHub Username: \033[01;37;40m";
    read USER;

    echo -ne "\033[00;37;40mGitHub Password: ";
    read -s PASS;

    echo -ne "\nGitHub Repo (e.g. foo/bar): \033[01;37;40m";
    read REPO;

    REPO_USER=$(echo "$REPO" | cut -f1 -d /);
    REPO_NAME=$(echo "$REPO" | cut -f2 -d /);

    echo -e "\n\033[01;36;40m## Label Settings ##\033[00;36;40m";

    echo -ne "\033[00;37;40mDo you want to delete the default issue labels from the repository (y/N)? \033[01;37;40m";
    read rmdefaults_yn;

    echo -e "";

    appTypeMenu;
    buildDeps;
}

function run() {
    ## Delete default labels
    case $rmdefaults_yn in
        [Yy]* )
            #deleteLabel "bug"
            #deleteLabel "duplicate"
            #deleteLabel "enhancement"
            #deleteLabel "invalid"
            #deleteLabel "question"
            #deleteLabel "wontfix"
        ;;
    esac

    ## Create labels
    #addLabel "P1: Blocker" "FF0000"
    #addLabel "P2: Critical" "FF8000"
    #addLabel "P3: Major" "FFFF00"
    #addLabel "P4: Minor" "40C040"
    #addLabel "P5: Trivial" "0000FF"
    #
    #addLabel "duplicate" "CCCCCC"
    #addLabel "invalid" "CCCCCC"
    #addLabel "planned" "20A020"
    #addLabel "unverified" "FFC000"
    #addLabel "wontfix" "000000"
    #
    #addLabel "bug" "FF0000"
    #addLabel "chore" "FFC000"
    #addLabel "documentation" "C080FF"
    #addLabel "enhancement" "80C0FF"
    #addLabel "feature request" "C04080"
    #addLabel "question" "8000FF"
    #addLabel "refactor" "0080C0"
    #
    ### This one needs to be done manually
    ###addLabel "¯\_(ツ)_/¯" "FFFFFF"
    #addLabel "breaks bc" "FF8000"
    #addLabel "code review" "0000FF"
    #addLabel "discussion" "C080FF"
    #addLabel "has PR" "20A020"
    #addLabel "help wanted" "FFA040"
    #addLabel "in progress" "0080C0"
    #addLabel "needs tests" "FFFF00"
    #addLabel "performance" "8000FF"
    #addLabel "regression" "FF0000"
    #addLabel "research" "C080FF"
    #addLabel "waiting" "FF8000"
    #
    #addLabel "LOE: Epic" "000000"
    #addLabel "LOE: High" "444444"
    #addLabel "LOE: Medium" "888888"
    #addLabel "LOE: Easy" "CCCCCC"
    #addLabel "LOE: Trivial" "FFFFFF"
    #
    #addLabel "angular" "C04080"
    #addLabel "css" "2080CC"
    #addLabel "grunt" "FFFF00"
    #addLabel "html" "C080FF"
    #addLabel "images" "8000FF"
    #addLabel "jquery" "80C0FF"
    #addLabel "tests" "FF8000"
    #addLabel "third party" "CCCCCC"
    #
    #addLabel "chrome" "2080CC"
    #addLabel "firefox" "FF8000"
    #addLabel "ie" "80C0FF"
    #addLabel "opera" "FFFF00"
    #addLabel "safari" "8000FF"
}

function addLabel() {
    curl --user "$USER:$PASS" --include --request POST --header "Content-Type: application/json" --data "{\"name\":\"$1\",\"color\":\"$2\"}" "https://api.github.com/repos/$REPO_USER/$REPO_NAME/labels" > /dev/null
}

function deleteLabel() {
    curl --user "$USER:$PASS" --include --request DELETE "https://api.github.com/repos/$REPO_USER/$REPO_NAME/labels/$1" > /dev/null
}

function appTypeMenu() {
    echo -e "\033[00;37;40mWhat kind of application is this?";
    echo -e "  1) Web application (front end only)";
    echo -e "  2) Web application (back end only)";
    echo -e "  3) Web application (front and back end)";
    echo -e "  4) Command line application";
    echo -ne "Your choice: \033[01;37;40m";
    read app_type;

    case $app_type in
        [1]* )
            thirdPartyMenu;
            frontEndAppMenu;
        ;;
        [2]* )
            languageMenu;
            backEndAppMenu;
        ;;
        [3]* )
            languageMenu;
            frontEndAppMenu;
            backEndAppMenu;
        ;;
        [4]* )
            languageMenu;
            cliAppMenu;
        ;;
        * )
            appTypeMenu;
        ;;
    esac
}

function languageMenu() {
    echo -e "\033[00;37;40mWhat is the primary language for your application?";
    echo -e "  1) PHP             4) Python";
    echo -e "  2) .NET            5) Perl";
    echo -e "  3) Java            6) Bash/Shell";
    echo -ne "Your choice: \033[01;37;40m";
    read app_language;
}

function thirdPartyMenu() {
    echo -ne "\033[00;37;40mDo you use any third-party libraries or frameworks (y/N)? \033[01;37;40m";
    read thirdparty_yn;
}

function buildDeps() {
    echo -ne "\033[00;37;40mGrunt (y/N)? \033[01;37;40m";
    read grunt_yn;
    echo -ne "\033[00;37;40mGulp (y/N)? \033[01;37;40m";
    read gulp_yn;
    echo -ne "\033[00;37;40mMake (y/N)? \033[01;37;40m";
    read make_yn;
    echo -ne "\033[00;37;40mnode.js / npm (y/N)? \033[01;37;40m";
    read nodenpm_yn;
}

function frontEndAppMenu() {
    case $thirdparty_yn in
        [Yy]* )
            echo -ne "\033[00;37;40mAngular (y/N)? \033[01;37;40m";
            read angular_yn;
            echo -ne "\033[00;37;40mBootstrap (y/N)? \033[01;37;40m";
            read bootstrap_yn;
            echo -ne "\033[00;37;40mBower (y/N)? \033[01;37;40m";
            read bower_yn;
            echo -ne "\033[00;37;40mjQuery (y/N)? \033[01;37;40m";
            read jquery_yn;
            echo -ne "\033[00;37;40mReact (y/N)? \033[01;37;40m";
            read react_yn;
        ;;
    esac
}

function backEndAppMenu() {
    case $thirdparty_yn in
        [Yy]* )
            case $app_language in
                [1]* )
                    phpThirdParty;
                ;;
                [2]* )
                ;;
                [3]* )
                ;;
                [4]* )
                ;;
                [5]* )
                ;;
                [6]* )
                ;;
            esac
        ;;
    esac
}

function phpThirdParty() {
    echo -ne "\033[00;37;40mComposer (y/N)? \033[01;37;40m";
    read composer_yn;
    echo -ne "\033[00;37;40mDrupal (y/N)? \033[01;37;40m";
    read drupal_yn;
    echo -ne "\033[00;37;40mSymfony (y/N)? \033[01;37;40m";
    read symfony_yn;
    echo -ne "\033[00;37;40mWordPress (y/N)? \033[01;37;40m";
    read wordpress_yn;
    echo -ne "\033[00;37;40mZend (y/N)? \033[01;37;40m";
    read zend_yn;
}

function cliAppMenu() {
    echo -e "";
}

init;