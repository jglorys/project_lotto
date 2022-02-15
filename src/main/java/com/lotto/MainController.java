package com.lotto;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
//@ResponseBody
//@Component
@RequestMapping("/lotto")
public class MainController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @ResponseBody
    @RequestMapping("/test")
    public String test() {
    	return "TEST!!";
    }
    
   
    @RequestMapping(value ="/test_view", method = RequestMethod.GET)
    public String testPageView() {
        return "testView";
    }

    @ResponseBody
    @RequestMapping(value = "/lotto_test", method = RequestMethod.POST)
    public Map<String, Object> testReturn(
            @RequestParam("bonus") String bonus,
            @RequestParam("turnNum") String turnNum,
            @RequestParam("numCnt") String numCnt) {
        Integer turnNumber = Integer.parseInt(turnNum);
        Integer numCount = Integer.parseInt(numCnt);

        ArrayList<List> arrList = new ArrayList<>();
        if (turnNumber >= 5) { // 5개
            arrList.add(Arrays.asList(2, 8, 19, 22, 32, 42, 39)); // 1000회차 - 22.1.29
            arrList.add(Arrays.asList(1, 3, 9, 14, 18, 28, 34)); // 999회차 - 22.1.22
            arrList.add(Arrays.asList(13, 17, 18, 20, 42, 45, 41)); // 998회차
            arrList.add(Arrays.asList(4, 7, 14, 16, 24, 44, 20)); //997
            arrList.add(Arrays.asList(6, 11, 15, 24, 32, 39, 28)); //996
            logger.debug("%%%%%%%%% 5회차 담음");
            if (turnNumber >=7) { // 2개
                arrList.add(Arrays.asList(1,4,13,29,38,39,7)); //995
                arrList.add(Arrays.asList(1,3,8,24,27,35,28)); //994
                logger.debug("%%%%%%%%% 7회차 담음");
                if (turnNumber == 10) { // 3개
                    arrList.add(Arrays.asList(6,14,16,18,24,42,44)); //993
                    arrList.add(Arrays.asList(12,20,26,33,44,45,24)); //992
                    arrList.add(Arrays.asList(13,18,25,31,33,44,38)); //991
                    logger.debug("%%%%%%%%% 10회차 담음");
                }
            }
        }

        // 받은 parameter로 random 돌릴 전체 개수 계산
        int bCnt = 0;
        if (bonus.equals("Y")) {
            bCnt = 7;
        } else if (bonus.equals("N")) {
            bCnt = 6;
        }
        int randomTotalCnt = bCnt * turnNumber; //Y , 10이면 0~69(70개)

        // result MAP
        Map<String, Object> result = new HashMap<>();


        ArrayList<Object> totalNum = new ArrayList<>();
        for ( List list : arrList) {
            if (arrList.size() != turnNumber) {
                logger.debug("arrList.size가" + turnNum + "과 일치하지 않습니다.");
                result.put("result", "false");
            }
            for (int i = 0 ; i < bCnt ; i++) {
                logger.debug("%%%%%%%%%%%% totalNum에 담기는 : " + list.get(i));
                totalNum.add(list.get(i));
            }
            logger.debug("::::::::::: list END :::::::::");
        }

        Set set = new HashSet(); //랜덤으로 numCnt개 받는 set 생성
        Random rand = new Random();
        int i = 1;
        //출력 빈도수 기록
        Map<Integer, Integer> resultFreq = new HashMap<>();
        while (set.size() != numCount ) {
            logger.debug("@@@@@@@@ " + i + "번째 뽑기");

            int index = rand.nextInt(randomTotalCnt); // 0~69
            int indexNum = (int) totalNum.get(index);
            logger.debug("**" + index + "번째 숫자는 : " + indexNum);
            set.add(indexNum);
            logger.debug(set.toString());
           
            // 빈도수 입력
            if (resultFreq.containsKey(indexNum)) {
                resultFreq.put(indexNum, resultFreq.get(indexNum) + 1);
            } else {
                resultFreq.put(indexNum, 1);
            }
            logger.debug(resultFreq.toString());
            i++;
        }

        //freq 빈도수 list에
        List<String> freqList = new ArrayList<String>();
        for (Map.Entry<Integer, Integer> entry : resultFreq.entrySet()) {
            freqList.add(entry.getKey() + "_" + entry.getValue());
        }
        
        result.put("result", "success");
        result.put("lottoList", freqList);
//        return set.toString();
        return result;
    }

    @RequestMapping(value = "/lotto_result_view", method = RequestMethod.GET)
    public String lottoResultView( Model model,
                                   @RequestParam("result") String result){

        logger.debug("BEFORE" + result);
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (String keyVal : List.of(result.split(","))) {
            freqMap.put(Integer.parseInt(keyVal.split("_")[0]), Integer.parseInt(keyVal.split("_")[1]));
//            logger.debug(freqMap.toString());
        }

        // 빈도수 Map 오름차순 정렬 - TreeMap 사용
        TreeMap<Integer, Integer> tm = new TreeMap<Integer, Integer>(freqMap);
        logger.debug(tm.toString());

        model.addAttribute("lotto", tm);
        return "testResultView";
    }

}
