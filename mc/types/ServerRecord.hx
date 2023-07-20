package mc.types;

typedef ServerRecord = {
	players:{
		sample:Array<{
			name:String,
			id:String
		}>, max:Int, online:Int
	},
	description:{
		text:String
	},
	favicon:String,
	version:{
		protocol:Int, name:String
	}
}
