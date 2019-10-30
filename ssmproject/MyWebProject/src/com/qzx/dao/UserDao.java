package com.qzx.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.qzx.pojo.Campus;
import com.qzx.pojo.GoodsInfo;
import com.qzx.pojo.User;

@Repository
public interface UserDao {
	public int insert(User user);
	public int findUser(@Param("username") String username,@Param("password") String password);
	public int findUserByUserName(String username);
	public User find(@Param("username") String username,@Param("password") String password);
	public int updatePerson(User user);
	public int updatePassword(@Param("username") String username,@Param("password") String password);
	
	public List<Campus> campusInfo();
	
	public List<GoodsInfo> goodsInfos();
	public int insertGoods(GoodsInfo goodsInfo);
}
