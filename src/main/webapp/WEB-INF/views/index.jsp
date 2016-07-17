<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>${siteTitle}<c:if test="${!siteEnv.equals('Production')}"> - ${siteEnv}</c:if></title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href='https://fonts.googleapis.com/css?family=Roboto:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <%--<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/project.css"/>--%>
</head>
<body>

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


<!-- inject:js -->
<script src="${pageContext.request.contextPath}/resources/scripts/app.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/controllers/home.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/services/research-area.service.js"></script>

<!-- endinject -->

<script>
    angular.element(document).ready(function () {
        angular.bootstrap(document, ["app"]);
    });
</script>

</body>
</html>