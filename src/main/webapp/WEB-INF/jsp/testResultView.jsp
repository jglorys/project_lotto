<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LOTTO RESULT</title>

    <!-- bootstrap CDN link -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <!-- AJAX를 사용하기 위해 slim 아닌 풀버전의 jquery로 교체 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container mt-5" style="border-radius: 2em; background-color: #ABEBC6;">
        <table class="table mt-5">
            <tr>
                <th>당첨 번호</th>
            <c:forEach var="numFreq" items="${lotto}">
                <c:set var="num" value="${numFreq.key}" />
                    <th>${num}</th>
            </c:forEach>
            </tr>
            <tr>
                <th>뽑힌 횟수</th>
            <c:forEach var="numFreq" items="${lotto}">
                <c:set var="freq" value="${numFreq.value}" />
                <c:if test="${freq eq 1}">
                    <td>${freq}</td>
                </c:if>
                <c:if test="${freq != 1}">
                    <th class="text-danger">${freq}</th>
                </c:if>
            </c:forEach>
            </tr>
        </table>
    </div>

</body>
</html>