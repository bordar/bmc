package com.borhan.bmc.modules.content.vo
{
	public class StreamVo
	{
		public static const STREAM_TYPE_BORHAN:String = 'borhan';
		public static const STREAM_TYPE_MULTICAST:String = 'multicast';
		public static const STREAM_TYPE_UNIVERSAL:String = 'universal';
		public static const STREAM_TYPE_MANUAL:String = 'manual';
		
		public var streamType:String = STREAM_TYPE_MANUAL;
		
		/**
		 * live stream name 
		 */
		public var streamName:String;
		
		/**
		 * live stream description 
		 */
		public var description:String;
		
		
		/* rtmp, hls/hds specific fields */
		/**
		 * primary ip for rtmp stream (legacy) and hls/hds stream (universal)   
		 */
		public var primaryIp:String;
		
		/**
		 * secondary ip for rtmp stream (legacy) and hls/hds stream (universal)   
		 */
		public var secondaryIp:String;
		
		/**
		 * broadcast password for rtmp stream (legacy) and hls/hds stream (universal)   
		 */
		public var password:String;
		
		/**
		 * is DVR enabled for akamai universal streams (hls/hds) and Borhan streams  
		 */
		public var dvrEnabled:Boolean;
		
		/* borhan stream specific */
		/**
		 * is recording enabled for Borhan streams  
		 */
		public var recordingEnabled:Boolean;
		
		/**
		 * append/per-session 
		 */
		public var recordingType:String;
		
		/**
		 * conversion profile to be used (Borhan streams)  
		 */
		public var conversionProfileId:int;
		
		
		/* manual stream specific fields */
		public var flashHDSURL:String;
		public var mobileHLSURL:String; 
		
		/**
		 * for HDS url, is it Akamai HDS  
		 */
		public var isAkamaiHds:Boolean; 
		
		

		
		public function StreamVo() {
		}
		
		

	}
}