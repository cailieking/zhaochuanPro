package com.cdd.base.enums;

public enum AgentType {
	ShipOwner("船东"),
	FirstAgent("一级货代"),
	SecondAgent("二级货代"),
	LittleAgent("中小货代"),
	CargoMen("直客");
  //类型（船东、一级货代 、二级货代、中小货代）
	private String text;
	
	private AgentType(String text) {
		this.text = text;
	}
	
	public String getText() {
		return text;
	}
	
	public static AgentType getCodeByText(String str) {
		if (AgentType.ShipOwner.text.equals(str)) {
			return AgentType.ShipOwner;
		} else if (AgentType.FirstAgent.text.equals(str)) {
			return AgentType.FirstAgent;
		} else if (AgentType.SecondAgent.text.equals(str)) {
			return AgentType.SecondAgent;
		} else if (AgentType.LittleAgent.text.equals(str)) {
			return AgentType.LittleAgent;
		}else if (AgentType.CargoMen.text.equals(str)) {
			return AgentType.CargoMen;
		} else {
			return null;
		}
	}
}
