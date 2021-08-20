package ghostcat.crm.workbench.dao;

import ghostcat.crm.workbench.domain.ClueActivityRelation;

import java.util.List;

public interface ClueActivityRelationDao {


    List<ClueActivityRelation> selectACRelationWithClueID(String clueId);

    int deleteClueActivityRelation(ClueActivityRelation clueActivityRelation);
}
