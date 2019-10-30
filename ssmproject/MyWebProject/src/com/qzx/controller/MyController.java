package com.qzx.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.qzx.params.ModPersonParams;
import com.qzx.params.RegParams;
import com.qzx.pojo.Campus;
import com.qzx.pojo.GoodsInfo;
import com.qzx.pojo.User;
import com.qzx.service.UserService;

@Controller
@RequestMapping("/guidian")
@SessionAttributes(names = { "SESSION_USERNAME", "loginName", "loginPassword", "userinfos", "yanzhengma" })
public class MyController {

	@Autowired
	private UserService userService;

	@RequestMapping("/index")
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login");
		return mv;
	}

	@RequestMapping("/main")
	public ModelAndView main(@SessionAttribute("userinfos") List<String> realName) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("realname", realName.get(0));
		mv.setViewName("index");
		return mv;
	}

	@RequestMapping("/register")
	@ResponseBody
	public String register(RegParams params) {
		int result = userService.findUserByUserName(params.getUsername());
		if (result > 0) {
			return "no";
		} else {
			User user = new User();
			user.setUsername(params.getUsername());
			user.setPassword(params.getPassword());
			user.setName(params.getName());
			user.setAge(Integer.parseInt(params.getAge()));
			user.setMail(params.getMail());
			if (params.getSex().equals("man")) {
				user.setSex("��");
				user.setPic("man");
			} else if (params.getSex().equals("female")) {
				user.setSex("Ů");
				user.setPic("female");
			}
			userService.insertData(user);
			return "ok";
		}
	}

	@RequestMapping("/login")
	@ResponseBody
	public String login(Model model, String username, String password) {
		int sum = userService.findUser(username, password);
		if (sum > 0) {
			model.addAttribute("loginName", username);
			model.addAttribute("loginPassword", password);
			model.addAttribute("SESSION_USERNAME", username);
			User userinfo = userService.find(username, password);
			List<String> userinfos = new ArrayList<>();
			userinfos.add(userinfo.getName());
			userinfos.add(userinfo.getSex());
			userinfos.add(String.valueOf(userinfo.getAge()));
			userinfos.add(userinfo.getMail());
			userinfos.add(userinfo.getPic());
			model.addAttribute("userinfos", userinfos);
			return "success";
		} else {
			return "error";
		}

	}

	@RequestMapping("/person")
	public ModelAndView person(@SessionAttribute("userinfos") List<String> userinfos) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", userinfos);
		mv.setViewName("person");
		return mv;
	}

	@RequestMapping("/modperson")
	public ModelAndView modPerson() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("modperson");
		return mv;
	}

	@RequestMapping("/modpwd")
	public ModelAndView modPwd() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("modpwd");
		return mv;
	}

	@RequestMapping("/communicate")
	public ModelAndView communicate() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("communication");
		return mv;
	}

	@RequestMapping("/lookinform")
	public ModelAndView lookinform() {
		ModelAndView mv = new ModelAndView();
		List<GoodsInfo> goodsList = userService.goodsInfos();
		if (goodsList.size() == 0) {
			goodsList.add(new GoodsInfo());
		}
		// ��������Ϊ�˱���lookinform.jspѭ��Խ������
		if (goodsList.size() % 3 == 1) {
			for (int i = 0; i < 2; i++) {
				goodsList.add(new GoodsInfo());
			}
		} else if (goodsList.size() % 3 == 2) {
			goodsList.add(new GoodsInfo());
		}
		mv.addObject("goodsList", goodsList);
		mv.setViewName("lookinform");
		return mv;
	}

	@RequestMapping("/issuance")
	public ModelAndView issuance() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("issuance");
		return mv;
	}

	@RequestMapping("/upload")
	public ModelAndView upload(MultipartFile pic, String describe) {
		ModelAndView mv = new ModelAndView();
		try {
			describe = new String(describe.getBytes("iso-8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String filename = pic.getOriginalFilename();
		if (filename.isEmpty()) {
			mv.addObject("msg", "��ûѡ��Ҫ�ϴ���ͼƬ");
		} else {
			GoodsInfo goodsInfo = new GoodsInfo();
			goodsInfo.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			goodsInfo.setPic(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())
					+ filename.substring(filename.indexOf(".")));
			goodsInfo.setWord("����Ʒ��" + describe + "�ҵ�");
			filename = filename.replace(filename, goodsInfo.getPic());
			userService.insertGoods(goodsInfo);
			pic.getContentType();
			File dest = new File(filename);
			try {
				pic.transferTo(dest);
				mv.addObject("msg", "�ϴ��ļ��ɹ�");
			} catch (Exception e) {
				mv.addObject("msg", "�ϴ��ļ�ʧ��");
				e.printStackTrace();
			}
		}
		mv.setViewName("issuance");
		return mv;
	}

	@RequestMapping("/campus")
	public ModelAndView campus() {
		ModelAndView mv = new ModelAndView();
		List<Campus> campusList = userService.campusInfo();
		if (campusList.size() == 0) {
			campusList.add(new Campus());
		}
		// ��������Ϊ�˱���campus.jspѭ��Խ������
		if (campusList.size() % 3 == 1) {
			for (int i = 0; i < 2; i++) {
				campusList.add(new Campus());
			}
		} else if (campusList.size() % 3 == 2) {
			for (int i = 0; i < 1; i++) {
				campusList.add(new Campus());
			}
		}
		mv.addObject("campusList", campusList);
		mv.setViewName("campus");
		return mv;
	}

	@RequestMapping("/modpwdjude")
	@ResponseBody
	public String modPwdJude(@SessionAttribute("loginName") String loginName,
			@SessionAttribute("loginPassword") String loginPassword, String orgpwd, String newpwd, String compwd) {

		if (orgpwd.equals(loginPassword) && newpwd.equals(compwd)) {
			userService.updatePassword(loginName, compwd);
			return "success";
		} else {
			return "error";
		}

	}

	@RequestMapping("/modifyperson")
	@ResponseBody
	public String modifyperson(ModPersonParams params, @SessionAttribute("yanzhengma") String yanzhengma,
			@SessionAttribute("loginName") String loginName, @SessionAttribute("userinfos") List<String> userinfos) {

		if (params.getValidate().equals(yanzhengma)) {
			User user = new User();
			user.setUsername(loginName);
			user.setName(params.getName());
			user.setSex(params.getSex());
			user.setAge(params.getAge());
			if (params.getMail().equals("")) {
				user.setMail(userinfos.get(3));
			} else {
				user.setMail(params.getMail());
			}
			if (params.getSex().equals("man")) {
				user.setPic("man");
			} else {
				user.setPic("female");
			}
			userService.updatePerson(user);
			return "success";
		} else {
			return "error";
		}

	}

	@RequestMapping("/sendmail")
	@ResponseBody
	public String sendMail(Model model, @SessionAttribute("userinfos") List<String> userinfos) {
		String str = "0123456789abcdefghijklmnopqrstuvwxzyABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer buffer = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < 4; i++) {
			char c = str.charAt(random.nextInt(str.length()));
			buffer.append(c);
		}
		String yanzhengma = buffer.toString();
		model.addAttribute("yanzhengma", yanzhengma);
		String result = sendTextEmail(userinfos.get(3), "��Ϣ�޸�", "��֤�룺" + yanzhengma);
		if (result.equals("success")) {
			return "success";
		} else {
			return "error";
		}
	}

	public String sendTextEmail(String target, String subject, String content) {

		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		// �ο�QQ�����������
		mailSender.setHost("smtp.qq.com"); // QQ����smtp���ͷ�������ַ
		// mailSender.setPort(465); // QQ����˿ڲ�����
		mailSender.setPort(587);// �˿ں�
		mailSender.setUsername("2522214743@qq.com"); // �˺�
		mailSender.setPassword("qxfkbivhhqqkecge"); // ��Ȩ��-�����Ż�ȡ
		// �ʼ���Ϣ
		SimpleMailMessage msg = new SimpleMailMessage();
		msg.setFrom("2522214743@qq.com"); // ����������
		msg.setTo(target); // �ռ�������
		msg.setSubject(subject); // ����
		msg.setText(content); // �ı���Ϣ
		try {
			mailSender.send(msg);
			System.out.println("�ʼ����ͳɹ�!");
			return "success";
		} catch (MailException ex) {
			System.err.println("����ʧ��:" + ex.getMessage());
			return "error";
		}
	}

	@RequestMapping("/exit")
	public String exit() {
		return "redirect:./index.do";
	}
}
