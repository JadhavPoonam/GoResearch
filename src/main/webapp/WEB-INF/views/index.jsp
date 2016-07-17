<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>${siteTitle}<c:if test="${!siteEnv.equals('Production')}"> - ${siteEnv}</c:if></title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href='https://fonts.googleapis.com/css?family=Roboto:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='https://ehs.ucop.edu/shared/brand/css/itsvc-font.css' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/project.css"/>
</head>
<body>

<noscript>
    <meta http-equiv="refresh" content="0; url=https://ehs.ucop.edu/browsercheck/options"/>
</noscript>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/browsercheck.js"></script>

<div ng-include="'${pageContext.request.contextPath}/resources/scripts/controllers/navigation/navigation.html'"></div>

<main class="container main-body" ng-view></main>
<div class="ribbon">
    <div class="container ${siteEnv.toLowerCase()}"></div>
</div>

<!-- inject:vendor:js -->
<script src="${pageContext.request.contextPath}/resources/lib/angular.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/angular-resource.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/angular-route.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/angular-sanitize.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/angulartics.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/angulartics-ga.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/jspdf.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/jspdf.plugin.autotable.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/angular-file-saver.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/lodash.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/ui-bootstrap-tpls.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/ng-file-upload.js"></script>
<!-- endinject -->

<script src="https://www.google.com/recaptcha/api.js?onload=vcRecaptchaApiLoaded&render=explicit" async defer></script>
<script src="${pageContext.request.contextPath}/resources/lib/uc-feedback.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/angular-recaptcha.min.js"></script>

<!-- inject:js -->
<script src="${pageContext.request.contextPath}/resources/scripts/app.js"></script>

<script src="${pageContext.request.contextPath}/resources/lib/uc-sidemenu.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/uc-profile-modal.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/services/profile.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/person.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/campus.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/radionuclide.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/ua.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/data.load.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/inventory.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/waste.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/monitorperson.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/bundle.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/soe.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/types.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/tile.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/sidemenu.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/license.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/permission.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/lhat.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/data.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/sealedsource.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/instrument.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/testrecord.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/machine.service.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/interceptors/authentication.interceptor.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/directives/ng-enter.directive.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/directives/history-back.directive.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/filters/telephone.filter.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/filters/text-to-html.filter.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/filters/newline.filter.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/filters/bytes.filter.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/filters/unique.filter.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/filters/date.filter.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/utils/static-collections.util.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/utils/module-collections.util.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/utils/constants.util.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/utils/inventory.util.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/components/wizard.component.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/components/attachment/attachment.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/navigation/navigation.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/navigation/right.navigation.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/home/home.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/ua/ua.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/ua/mua.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/ua/ua-new.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/ua/ua-edit.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/ua/ua-summary.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.use-log.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.lab.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.request.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.detail.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.receive.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.self-report.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.package.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/inventory.waste.detail.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/inventory/instruments.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/personal-information/personal-information.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/lab/lab.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/planned-work/planned-work.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/planned-work/machine-planned-work.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/soe/soe.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/soe/experience.step.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/soe/dosimetry.step.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/soe/training.step.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/soe/summary.step.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/admin.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/reports/radionuclide-report.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/reports/unity-report.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/reports/material-request-report.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/reports/monitoring-report.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/reports/calibration-report.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/reports/surveys-report.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/surveys/sealed-sources.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/surveys/instruments-calibrations.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/ua/ua-summary.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/settings.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/agreement.setting.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/billing.settings.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/role.management.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/billing/billing.mngt.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/ehs/ehs.js"></script>

<script src="${pageContext.request.contextPath}/resources/scripts/controllers/license/radionuclide.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/ua-backfill.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/inventory.settings.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/admin/modal-controller.js"></script>
<!-- endinject -->

<script>
    angular.element(document).ready(function () {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', './api/person/profile', true);
        xhr.setRequestHeader('shibtoken', window.sessionStorage.getItem('shibtoken'));
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    if (xhr.responseText === 'fastlane') {
                        window.location.replace('${fastlaneUrl}');
                        return;
                    }
                    var data = JSON.parse(xhr.responseText);
                    angular.module('app').constant('CURRENT_USER', data);
                    angular.module('app').constant('TITLE', '${siteTitle}');
                    angular.module('app').constant('ENV', '${siteEnv}');
                    angular.module('app').constant('VERSION', '${siteVersion}');
                    angular.module('app').constant('BUILD', '${siteBuild}');
                    angular.module('app').constant('BRAND_URL', '${brandUrl}');
                    angular.module('app').constant('CLIENT_KEY', '${clientKey}');
                    angular.module('app').constant('PROFILE_URL', '${profileUrl}');
                    angular.module('app').constant('DEVTOOL', ${devtool});
                    angular.module('app').constant('ORIGINAL_URL_STORAGE_KEY', '${originalUrlStorageKey}');
                    angular.module('app').constant('SHIB_URL', '${shibUrl}');
                    angular.module('app').constant('CONTEXT_PATH', '${pageContext.request.contextPath}');
                    angular.bootstrap(document, ["app"]);
                } else if (xhr.status === 401) {
                    window.sessionStorage.setItem('originalUrl', window.location.hash.replace('#', ''));
                    window.location.replace('${shibUrl}');
                    }
                }
        };
        xhr.send();
    });
</script>

<%--Google Analytics--%>
<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date();
        a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-65519397-1', 'auto');
    ga('create', 'UA-68039111-1', 'auto', {'name': 'ucSafety'});
    ga('send', 'pageview');
    ga('ucSafety.send', 'pageview');

</script>

</body>
</html>