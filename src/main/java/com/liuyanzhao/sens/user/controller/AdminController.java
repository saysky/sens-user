package com.liuyanzhao.sens.user.controller;

import com.liuyanzhao.sens.user.common.dto.JsonResult;
import com.liuyanzhao.sens.user.common.enums.ResultCodeEnum;
import com.liuyanzhao.sens.user.entity.Permission;
import com.liuyanzhao.sens.user.service.PermissionService;
import com.liuyanzhao.sens.user.service.UserService2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * <pre>
 *     后台首页控制器
 * </pre>
 *
 * @author : saysky
 * @date : 2017/12/5
 */
@Slf4j
@Controller
@RequestMapping(value = "/admin")
public class AdminController extends BaseController {

    @Autowired
    private UserService2 userService;

    @Autowired
    private PermissionService permissionService;

    /**
     * 获得当前用户的菜单
     *
     * @return
     */
    @GetMapping(value = "/currentMenus")
    @ResponseBody
    public JsonResult getMenu() {
        Long userId = getLoginUserId();
        List<Permission> permissions = permissionService.findPermissionTreeByUserIdAndResourceType(userId, "menu");
        return new JsonResult(ResultCodeEnum.SUCCESS.getCode(), "", permissions);
    }


}
