package ghostcat.crm.vo;

import java.util.List;

public class PageVo<T> {
    private Integer total;
    private List<T> pageList;

    public PageVo() {
    }

    public PageVo(Integer total, List<T> pageList) {
        this.total = total;
        this.pageList = pageList;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<T> getPageList() {
        return pageList;
    }

    public void setPageList(List<T> pageList) {
        this.pageList = pageList;
    }

    @Override
    public String toString() {
        return "PageVo{" +
                "total=" + total +
                ", pageList=" + pageList +
                '}';
    }
}
