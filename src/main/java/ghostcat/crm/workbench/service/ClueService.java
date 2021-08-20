package ghostcat.crm.workbench.service;


import ghostcat.crm.exception.ConvertException;
import ghostcat.crm.workbench.domain.Clue;
import ghostcat.crm.workbench.domain.ClueRemark;
import ghostcat.crm.workbench.domain.Tran;

import java.util.List;

public interface ClueService {
    int addClue(java.lang.String fullname, java.lang.String appellation, java.lang.String owner, java.lang.String company, java.lang.String job, java.lang.String email, java.lang.String phone, java.lang.String website, java.lang.String mphone, java.lang.String state, java.lang.String source, java.lang.String description, java.lang.String contactSummary, java.lang.String nextContactTime, java.lang.String address, java.lang.String createTime, java.lang.String createBy, java.lang.String id);

    List<Clue> queryClue(Integer pageNo, Integer pageSize, String fullname, String company, String phone, String source, String owner, String mphone, String state);

    Integer queryClueCount(String fullname, String company, String phone, String source, String owner, String mphone, String state);

    List<Clue> queryAllClue(String id);

    int editClue(String id, String fullname, String appellation, String owner, String company, String job, String email, String phone, String website, String mphone, String state, String source, String description, String contactSummary, String nextContactTime, String address, String editTime, String editBy);

    int deleteClue(String id);

    int deleteClueRemark(String id);

    Clue queryClueWithID(String id);

    List<ClueRemark> queryClueRemarkWithClueID(String id);

    int deleteClueInDetail(String id);

    int addClueRemark(String id, String noteContent, String createTime, String createBy, String editFlag, String clueId);

    List<ClueRemark> queryClueRemarkWithID(String id);

    int editClueRemark(String id, String noteContent, String editBy, String editTime, String editFlag);

    int deleteClueRemarkWithID(String id);

    int deleteRelationWithID(String id);

    int addRelation(String clueId, String activityId, String id);

    boolean convert(String clueId, Tran tran, String createBy) throws ConvertException;

    int deleteClueActivityRelationWithCID(String id);
}
