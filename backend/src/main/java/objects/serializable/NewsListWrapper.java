package objects.serializable;

import java.util.List;

public class NewsListWrapper {
    private List<News> list;
    public NewsListWrapper(List<News> list) {
        this.list = list;
    }
    public List<News> getList() {
        return list;
    }
    public void setList(List<News> list) {
        this.list = list;
    }
}
