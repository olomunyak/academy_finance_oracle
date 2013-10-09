
-- 싱글뷰
SELECT *
FROM BOARD_LIST;

-- 인라인뷰
SELECT *
FROM (
      SELECT B.BOARD_TXTNUM, B.MEM_ID, B.BOARD_CGY, B.BOARD_TIT, B.BOARD_CTN, B.BOARD_REGIDATE, B.BOARD_HITS, RANK() OVER(ORDER BY B.BOARD_TXTNUM ASC) AS RNK
      FROM BOARD B INNER JOIN MEMBER M
                           ON B.MEM_ID = M.MEM_ID
      ORDER BY RNK DESC
);

-- 통칭해서 뷰라고 불리는 애들
-- 결국은 서브쿼리와 같다.
-- 싱글뷰와 인라인뷰는 차이가 없다. 오로지 차이가 나는건 마테리얼라이즈 뷰다.
-- 특정이름으로 묶어놓으면 싱글뷰고 풀어쓰면 인라인뷰다.
-- 데이터와 뷰를 구분짓는건 저장하고 안하고의 차이다. 
-- 저장되어 있느냐? 만들어진? 가공되어진 것이냐? 로 뷰를 구분한다.

-- 뷰의 경우는 싱글뷰와 인라인뷰가 있다.
-- 하지만 오라클의 경우 마테리얼라이즈 뷰도 있다.
-- 뷰는 가공된 데이터에 이름을 붙여 놓은것이다.
-- 마테리얼라이즈뷰는 가공된 데이터를 저장해 놓은 것이다.

SELECT *
FROM (
      SELECT B.BOARD_TXTNUM, B.MEM_ID, B.BOARD_CGY, B.BOARD_TIT, B.BOARD_CTN, B.BOARD_REGIDATE, B.BOARD_HITS, RANK() OVER(ORDER BY B.BOARD_TXTNUM ASC) AS RNK
      FROM BOARD B INNER JOIN MEMBER M
                           ON B.MEM_ID = M.MEM_ID
      ORDER BY RNK DESC
     ) A INNER JOIN BOARD B
                 ON A.BOARD_TXTNUM = B.BOARD_TXTNUM;