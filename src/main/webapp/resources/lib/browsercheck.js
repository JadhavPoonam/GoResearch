// CONFIG START
// replace minVersion of specific browser with the minimum version number
// that this app is compatible with eg. If your app is compatible with safari 19
// then {name: 'Apple Safari',
//		code: 'safari',
//		minVersion: '19'},
var minimumVersions = [
    {
        name: 'Microsoft Internet Explorer',
        code: 'msie',
        minVersion: '10'
    },
    {
        name: 'Mozilla FireFox',
        code: 'firefox',
        minVersion: '20'
    },
    {
        name: 'Google Chrome',
        code: 'chrome',
        minVersion: '30'
    },
    {
        name: 'Apple Safari',
        code: 'safari',
        minVersion: '5'
    },
    {
        name: 'Opera',
        code: 'opera',
        minVersion: '5'
    }
];

// browserCompatibilityURL
var browserCompatibilityURL = 'https://ehs.ucop.edu/browsercheck/options';
// CONFIG END

window.onload = function () {
    verifyBrowserCompatibility();
};

function verifyBrowserCompatibility() {

    var browser = getBrowser();

    for (var i = 0; i < minimumVersions.length; i++) {
        if (browser.name.toLowerCase().indexOf(minimumVersions[i].code) != -1) {
            if (parseFloat(browser.version) < parseFloat(minimumVersions[i].minVersion)) {
                showBrowserCompatibilityPage();
                return;
            }
        }
    }
}

function getBrowser() {
    var ua = navigator.userAgent;
    var tem;
    var M = ua.match(/(opera|safari|chrome|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    if (/trident/i.test(M[1])) {
        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
        return {
            name: 'MSIE',
            version: tem[1]
        };
    }
    if (M[1] === 'Chrome') {
        tem = ua.match(/\bOPR\/(\d+)/)
        if (tem != null) {
            return {
                name: 'Opera',
                version: tem[1]
            };
        }
    }
    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
    if ((tem = ua.match(/version\/(\d+)/i)) != null) {
        M.splice(1, 1, tem[1]);
    }

    return {
        name: M[0],
        version: M[1]
    };
}

function showBrowserCompatibilityPage() {
    var redirectURL = browserCompatibilityURL;
    window.location.href = redirectURL;
}