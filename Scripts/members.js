$(document).ready(function () {
    startUp();
});

// ******** Start on Page_Load
function startUp() {
    goNightClub();
}
// ******** Start on Page_Load [end]

// ******** Luma Screen Switching
var timeoutLumaView = 0;
var viewLuma = 0;
function switchLumaView() {
    if (timeoutLumaView != 0) {
        clearTimeout(timeoutLumaView);
    }

    switch (viewLuma++) {
        case 0:
            $("#dayRoomWallImageA").show();
            $("#TVDR01Holder").show();
            break;
        case 1:
            $("#dayRoomWallImageA").show();
            $("#TVDR01Holder").show();
            $("#TVDR03Holder").hide();
            $("#dayRoomWallImageC").hide();
            break;
        case 2:
            $("#dayRoomWallImageB").show();
            $("#TVDR02Holder").show();
            $("#TVDR01Holder").hide();
            $("#dayRoomWallImageA").hide();
            break;
        case 3:
            $("#dayRoomWallImageC").show();
            $("#TVDR03Holder").show();
            $("#TVDR02Holder").hide();
            $("#dayRoomWallImageB").hide();
            viewLuma = 1;
            break;
    }

    timeoutLumaView = setTimeout("switchLumaView()", 2*60*1000);
}
// ******** Luma Screen Switching [end]

// ******** Room selection animation
var currentRoom = 0;
function setRoom(selectedRoom) {
    if (currentRoom != selectedRoom) {
        switch (currentRoom) {
            case 0:
                $("#nightClubWall").hide();
                $("#TVMWHolder").hide();
                $("#TVMW01Holder").hide();
                $("#TVMW02Holder").hide();
                $("#TVMW03Holder").hide();
                $("#TVMW04Holder").hide();
                break;
            case 1:
                $("#dayRoomWall").hide();
                $("#TVDRHolder").hide();
                break;
        }
    }

    switch (selectedRoom) {
        case 0:
            $("#nightClubWall").show();
            $("#MessageScrollBox").css('color', 'red');
            $("#TVMWHolder").delay(3000).show();
            $("#TVMW01Holder").show();
            $("#TVMW02Holder").show();
            $("#TVMW03Holder").show();
            $("#TVMW04Holder").show();
            break;
        case 1:
            $("#MessageScrollBox").css('color', 'white');
            $("#TVDRHolder").show();
            $("#dayRoomWall").show();
            break;
    }

    currentRoom = selectedRoom;
}

function goNightClub() {
    setRoom(0);
}

function goDayRoom() {
    setRoom(1);
}

// ******** Room selection animation [end]

var thetime = new Date();
var nhours = thetime.getHours();
var nmins = thetime.getMinutes();
var nsecn = thetime.getSeconds();
// feed chat
function feedChat() {
    document.getElementById('chatField').innerHTML += '<font style="color: red; font-weight: bold; margin-left: 2px;">Lynn (' + nhours + ':' + nmins + ':' + nsecn + ')</font>: ' + document.getElementById('chatFeed').value + '<br />';
    document.getElementById('chatFeed').value = '';
}
