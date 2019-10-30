package com.qzx.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qzx.dao.UserDao;
import com.qzx.pojo.Campus;
import com.qzx.pojo.GoodsInfo;
import com.qzx.pojo.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	@Override
	public int insertData(User user) {
		return userDao.insert(user);
	}
	@Override
	public int findUser(String username, String password) {
		return userDao.findUser(username, password);
	}
	@Override
	public int findUserByUserName(String username) {
		return userDao.findUserByUserName(username);
	}
	@Override
	public User find(String username, String password) {
		return userDao.find(username, password);
	}
	@Override
	public int updatePerson(User user) {
		return userDao.updatePerson(user);
	}
	@Override
	public int updatePassword(String username, String password) {
		return userDao.updatePassword(username, password);
	}
	@Override
	public List<Campus> campusInfo() {
		return userDao.campusInfo();
	}
	@Override
	public List<GoodsInfo> goodsInfos() {
		return userDao.goodsInfos();
	}
	@Override
	public int insertGoods(GoodsInfo goodsInfo) {
		return userDao.insertGoods(goodsInfo);
	}
	
	
}
