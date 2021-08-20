package ghostcat.crm.workbench.dao;

import ghostcat.crm.workbench.domain.Clue;
import ghostcat.crm.workbench.domain.ClueRemark;

import java.util.List;
import java.util.Map;

public interface ClueDao {


    int insertClue(Clue clue);

    List<Clue> selectClue(Clue clue);

    Integer selectClueCount(Clue clue);

    List<Clue> selectAllClue(String id);

    int updateClue(Clue clue);

    int deleteClue(String id);

    int deleteClueRemark(String id);

    Clue selectClueWithID(String id);

    List<ClueRemark> selectClueRemarkWithClueID(String id);

    int deleteClueInDetail(String id);

    int insertClueRemark(Map<String, String> map);

    List<ClueRemark> selectClueRemarkWithID(String id);

    int updateClueRemark(Map<String, String> map);

    int deleteClueRemarkWithID(String id);

    int deleteRelationWithID(String id);

    int insertRelation(Map<String, String> map);

    Clue selectClueWithID2(String clueId);

    int deleteClueActivityRelationWithCID(String id);
}
