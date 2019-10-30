package com.qzx.service;

import java.util.List;

import com.qzx.pojo.Campus;
import com.qzx.pojo.GoodsInfo;
import com.qzx.pojo.User;

public interface UserService {
	public int insertData(User user);
	public int findUser(String username,String password);
	public int findUserByUserName(String username);
	public User find(String username,String password);
	public int updatePerson(User user);
	public int updatePassword(String username,String password);
	
	public List<Campus> campusInfo();
	
	public List<GoodsInfo> goodsInfos();
	public int insertGoods(GoodsInfo goodsInfo);
}
