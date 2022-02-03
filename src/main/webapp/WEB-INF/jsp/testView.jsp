<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LOTTO</title>

    <!-- bootstrap CDN link -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <!-- AJAX를 사용하기 위해 slim 아닌 풀버전의 jquery로 교체 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container col-5 mt-5">
        <div class="m-5 P-5">
            <h4>보너스번호 포함여부</h4>
            <select id="bonusSelect" class="form-control">
                <option value="none" disabled selected>=== 선택 ===</option>
                <option value="Y">보너스번호 포함</option>
                <option value="N">보너스번호 포함X</option>
            </select>
        </div>
        <div class="m-5 P-5">
            <h4>회차 수 선택</h4>
            <select id="turnNumSelect" class="form-control">
                <option value="none" disabled selected>=== 선택 ===</option>
                <option value="10">최근 10회차</option>
                <option value="7">최근 7회차</option>
                <option value="5">최근 5회차</option>
            </select>
        </div>
        <div class="m-5 P-5">
            <h4>랜덤으로 뽑을 숫자 개수 선택</h4>
            <select id="numCountSelect" class="form-control">
                <option value="none" disabled selected>=== 선택 ===</option>
                <option value="6">6개</option>
                <option value="5">5개</option>
                <option value="4">4개</option>
                <option value="3">3개</option>
            </select>
        </div>
        <div class="d-flex justify-content-center mt-5">
            <button type="button" id="lottoBtn" class="btn mt-5" style="background-color: #ABEBC6;border-radius: 1em;height: 45px ;width: 300px;">Lotto</button>
        </div>
    </div>

    <script>
        $(document).ready(function(){
            //lottoBtn Click
            $('#lottoBtn').on('click', function(){
                let bonus = $('#bonusSelect').val();
                if (bonus == null) {
                    alert('보너스번호 포함여부를 선택해주세요');
                    return;
                }
                let turnNum = $('#turnNumSelect').val();
                if (turnNum == null) {
                    alert('회차 수를 선택해주세요');
                    return;
                }
                let numCnt = $('#numCountSelect').val();
                if (numCnt == null) {
                    alert('랜덤으로 뽑을 숫자의 개수를 선택해주세요');
                    return;
                }
                alert(bonus + ' / ' + turnNum + ' / ' + numCnt);

                let formData = new FormData();
                formData.append('bonus',bonus);
                formData.append('turnNum', turnNum);
                formData.append('numCnt', numCnt);

                $.ajax({
                   type: 'post',
                   url: '/lotto_test',
                   data: formData,
                   processData: false,
                   contentType: false,
                    success: function(data) {
                        if (data.result == 'success') {
                            // alert('Lotto 뽑기 완료!');
                            // alert(data.resultList);
                            location.href="/lotto_result_view?&result=" + data.lottoList;
                        } else if (data.result == 'false') {
                            alert('arrList 에러 발생');
                            location.reload();
                        }
                    },
                    error: function(e) {
                        alert('Lotto 뽑기에 실패했습니다.' + e);
                    }
                });
            });
        });
    </script>

</body>
</html>