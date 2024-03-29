package com.liuyanzhao.sens.user.common.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * @author liuyanzhao
 */
@Data
public class SearchVo implements Serializable {

    /**
     * 起始日期
     */
    private String startDate;

    /**
     * 结束日期
     */
    private String endDate;
}
