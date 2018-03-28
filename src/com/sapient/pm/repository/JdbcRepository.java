package com.sapient.pm.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sapient.pm.db.MySQLConnectorFactory;
import com.sapient.pm.model.Trader;




public class JdbcRepository {
	
	public void save(Trader trader) {
		Connection connection= null;
		
		try {
			connection= MySQLConnectorFactory.getConnection();
			
			System.out.println(connection);
			
			String sql="insert into trader (traderId, ticker, quantity,  side) values(?,?,?,?)";
			PreparedStatement ps= connection.prepareStatement(sql);
			System.out.println(trader.getTraderId());
			ps.setInt(1, trader.getTraderId());
			ps.setString(2, trader.getTicker());
			ps.setInt(3, trader.getQuantity());
			ps.setString(4, trader.getSide());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
	public int getMarketData(String s) throws SQLException {
		
		Connection connection= null;
		int rr=0;
		
			connection= MySQLConnectorFactory.getConnection();
		
		String sql= "select * from marketData where ticker=?";
		
		PreparedStatement ps= connection.prepareStatement(sql);
		ps.setString(1, s);
		ResultSet rs= ps.executeQuery();
		rs.next();
		rr=rs.getInt("price");
		
		
		
		return rr;
		
		
	}
	public List<Trader> findAll()  {
		Connection connection= null;
		List<Trader> traders = new ArrayList<>();
		
		
			try {
				connection= MySQLConnectorFactory.getConnection();
				String sql= "select ob.ticker, md.price, sum(ob.quantity)-(select sum(quantity) from orderbook where side = \"sell\" and status=1 and ticker=ob.ticker) from orderbook  ob \r\n" + 
						"join marketdata md \r\n" + 
						"on md.ticker= ob.ticker\r\n" + 
						"where side = \"buy\" and status = 1 \r\n" + 
						"group by ob.ticker";
				PreparedStatement ps= connection.prepareStatement(sql);
				
				ResultSet rs= ps.executeQuery();
				System.out.println(rs);
				while(rs.next()) {
					Trader trader = new Trader();
					trader.setTicker(rs.getString(1));
					trader.setQuantity(rs.getInt(2));
					trader.setPrice(rs.getDouble(3));
					System.out.println(trader.getTicker());
					//System.out.println("Values added");
					
					traders.add(trader);
			
			
			
			
		}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return traders;
			
	
	}}

	
	

