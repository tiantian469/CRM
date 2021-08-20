package ghostcat.crm.workbench.dao;

import ghostcat.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {

    int insertTran(Tran tran);

    List<Tran> selectAllTran(Map<String, Object> tranMap);

    int selectAllTranCount(Map<String, Object> tranMap);

    int insertTran2(Map<String, String> stringMap);

    Tran selectTranWithId(String id);

    Tran selectTranWithId2(String id);

    int updateTran(Map<String, String> stringMap);

    int deleteInDetail(String id);

    int updateTranStage(Map<String, String> stringMap);

    int selectAllTranCount2();

    List<Map<Integer,String>> selectGroupByStage();
}
