package com.liuyanzhao.sens.user.service.impl;

import com.liuyanzhao.sens.user.common.constant.SensConst;
import com.liuyanzhao.sens.user.common.enums.BlogPropertiesEnum;
import com.liuyanzhao.sens.user.common.utils.SensUtils;
import com.liuyanzhao.sens.user.service.MailService;
import freemarker.template.Template;
import io.github.biezhi.ome.OhMyEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.io.File;
import java.util.Map;

/**
 * <pre>
 *     邮件发送业务逻辑实现类
 * </pre>
 *
 * @author : saysky
 * @date : 2018/1/23
 */
@Service
public class MailServiceImpl implements MailService {

    @Autowired
    private FreeMarkerConfigurer freeMarker;

    /**
     * 发送邮件
     *
     * @param to      to 接收者
     * @param subject subject 标题
     * @param content content 内容
     */
    @Override
    public void sendMail(String to, String subject, String content) {
        //配置邮件服务器
        SensUtils.configMail(
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_HOST.getProp()),
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_USERNAME.getProp()),
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_PASSWORD.getProp()));
        try {
            OhMyEmail.subject(subject)
                    .from(SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_FROM_NAME.getProp()))
                    .to(to)
                    .text(content)
                    .send();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 发送模板邮件
     *
     * @param to           接收者
     * @param subject      主题
     * @param content      内容
     * @param templateName 模板路径
     */
    @Override
    public void sendTemplateMail(String to, String subject, Map<String, Object> content, String templateName) {
        //配置邮件服务器
        SensUtils.configMail(
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_HOST.getProp()),
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_USERNAME.getProp()),
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_PASSWORD.getProp()));
        String text = "";
        try {
            Template template = freeMarker.getConfiguration().getTemplate(templateName);
            text = FreeMarkerTemplateUtils.processTemplateIntoString(template, content);
            OhMyEmail.subject(subject)
                    .from(SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_FROM_NAME.getProp()))
                    .to(to)
                    .html(text)
                    .send();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 发送带有附件的邮件
     *
     * @param to           接收者
     * @param subject      主题
     * @param content      内容
     * @param templateName 模板路径
     * @param attachSrc    附件路径
     */
    @Override
    public void sendAttachMail(String to, String subject, Map<String, Object> content, String templateName, String attachSrc) {
        //配置邮件服务器
        SensUtils.configMail(
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_HOST.getProp()),
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_USERNAME.getProp()),
                SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_SMTP_PASSWORD.getProp()));
        File file = new File(attachSrc);
        String text = "";
        try {
            Template template = freeMarker.getConfiguration().getTemplate(templateName);
            text = FreeMarkerTemplateUtils.processTemplateIntoString(template, content);
            OhMyEmail.subject(subject)
                    .from(SensConst.OPTIONS.get(BlogPropertiesEnum.MAIL_FROM_NAME.getProp()))
                    .to(to)
                    .html(text)
                    .attach(file, file.getName())
                    .send();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
