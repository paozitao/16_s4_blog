function ismobile() {
    var mobileArry = ["iPhone", "iPad", "Android", "Windows Phone", "BB10; Touch", "BB10; Touch", "PlayBook", "Nokia"];
    var ua = navigator.userAgent;
    var res=mobileArry.filter(function(arr) {
        return ua.indexOf(arr) > 0;
    });
    return res.length > 0;
}