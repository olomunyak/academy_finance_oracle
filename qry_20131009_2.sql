

-- 소분류로 매핑하고 대분류로 필터를 준다. 그렇게 하면 원하는데로 가져다 쓸 수 있다.
-- 쿼리를 짤때는 필터를 선언해놓고(필요한 부분은 다 짜놓고) 불러온다.
-- SELECT에서 가장 중요한 것은 '필요한 부분만 가져다 쓴다'는 것이다.

-- 일반적인 VIEW는 단순한 쿼리를 줄여놓은 것에 불과하다.
-- 긴 쿼리가 한번에 준다.
-- 쿼리를 줄일때 쓰는 방법이 VIEW다.
-- VIEW는 쿼리를 줄이는 역할밖에 안된다. 그냥 쿼리 자체를 미리 저장해 놓은 것이다.
SELECT *
FROM BOARD_LIST;
-- 싱글뷰(일반적으로 보는 단독적인 뷰다.)
-- 싱글뷰는 단순 뷰 기능만 한다.
-- 마테리얼라이즈 뷰(물질뷰, MVIEW) - 테이블같이 실질적으로 공간을 차지하고 있는 뷰다.
-- 사용하면 속도는 확연히 빠르지만 그만큼 저장 공간을 가져간다.

-- DEMAND는 리프레시를 해줘야 한다.
UPDATE BOARD SET BOARD_CTN = 'bba bba bba bbabba'
WHERE BOARD_TXTNUM = 40;

SELECT *
FROM BOARD_MLIST_VIEW;

-- 프로시저를 실행한다.
-- 프로시저 - 오라클에다가 메소드를 만들어 놓은 것이다.
-- ==> 익명블록이 완료되었습니다.

-- EXECUTE DBMS의 MVIEW에 있는 REFRESH를 호출하는데 인자로는 BOARD_MLIST_VIEW를 넘기겠다.
-- FAST, COMPLETE, FORCE에 따라서 변경된 부분이 적용이 된다.
EXECUTE DBMS_MVIEW.REFRESH('BOARD_MLIST_VIEW');
