
//`define ENABLE_ADC
//`define ENABLE_AUD
//`define ENABLE_CLOCK2
//`define ENABLE_CLOCK3
//`define ENABLE_CLOCK4
`define ENABLE_CLOCK
`define ENABLE_DRAM
//`define ENABLE_FAN
`define ENABLE_FPGA
`define ENABLE_GPIO
`define ENABLE_HEX
//`define ENABLE_HPS
//`define ENABLE_IRDA
`define ENABLE_KEY
`define ENABLE_LEDR
//`define ENABLE_PS2
//`define ENABLE_TD
`define ENABLE_VGA
`define ENABLE_SW

module de1_soc(

      `ifdef ENABLE_ADC
      output             ADC_CONVST,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,
      `endif

      `ifdef ENABLE_AUD
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_XCK,
      `endif

      `ifdef ENABLE_CLOCK2
      input              CLOCK2_50,
      `endif

      `ifdef ENABLE_CLOCK3
      input              CLOCK3_50,
      `endif

      `ifdef ENABLE_CLOCK4
      input              CLOCK4_50,
      `endif

      `ifdef ENABLE_CLOCK
      input              CLOCK_50,
      `endif

      `ifdef ENABLE_DRAM
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,
      `endif

      `ifdef ENABLE_FAN
      output             FAN_CTRL,
      `endif

      `ifdef ENABLE_FPGA
      inout             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,
      `endif

      `ifdef ENABLE_GPIO
		inout     [35:0]    GPIO_0,
		inout     [35:0]    GPIO_1,
      `endif

      `ifdef ENABLE_HEX
      output      [6:0]  HEX0,
      output      [6:0]  HEX1,
      output      [6:0]  HEX2,
      output      [6:0]  HEX3,
      output      [6:0]  HEX4,
      output      [6:0]  HEX5,
      `endif

      `ifdef ENABLE_HPS
      inout              HPS_CONV_USB_N,
      output      [14:0] HPS_DDR3_ADDR,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_N,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_N,
      output             HPS_DDR3_CK_P,
      output             HPS_DDR3_CS_N,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_N,
      inout       [3:0]  HPS_DDR3_DQS_P,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_N,
      output             HPS_DDR3_RESET_N,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_N,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_N,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C1_SCLK,
      inout              HPS_I2C1_SDAT,
      inout              HPS_I2C2_SCLK,
      inout              HPS_I2C2_SDAT,
      inout              HPS_I2C_CONTROL,
      inout              HPS_KEY,
      inout              HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      inout              HPS_SPIM_SS,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
      `endif

      `ifdef ENABLE_IRDA
      input              IRDA_RXD,
      output             IRDA_TXD,
      `endif

      `ifdef ENABLE_KEY
      input       [3:0]  KEY,
      `endif

      `ifdef ENABLE_LEDR
      output      [9:0]  LEDR,
      `endif

      `ifdef ENABLE_PS2
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,
      `endif

      `ifdef ENABLE_TD
      input             TD_CLK27,
      input      [7:0]  TD_DATA,
      input             TD_HS,
      output            TD_RESET_N,
      input             TD_VS,
      `endif

      `ifdef ENABLE_VGA
      output      [7:0]  VGA_B,
      output             VGA_BLANK_N,
      output             VGA_CLK,
      output      [7:0]  VGA_G,
      output             VGA_HS,
      output      [7:0]  VGA_R,
      output             VGA_SYNC_N,
      output             VGA_VS,
      `endif

      `ifdef ENABLE_SW
      input       [9:0]  SW
      `endif
);

	wire [11:0] dram_address;
	assign DRAM_ADDR = {1'b0, dram_address};

    top my_top (
		//clocks & reset
		.clk50         ( CLOCK_50 ),             
		.rst           ( KEY[0]   ),
		
		// camera
		.data_cam      ( GPIO_0[7:0]  ),
		.VSYNC_cam     ( GPIO_0[8]  ),
		.HREF_cam      ( GPIO_0[9]  ),
		.PCLK_cam      ( GPIO_0[10]  ),
		.XCLK_cam      ( GPIO_0[11]  ),
		.res_cam       ( GPIO_0[12]  ),
		.on_off_cam    ( GPIO_0[13]  ),
		.sioc          ( GPIO_0[14]  ),
		.siod          ( GPIO_0[15]  ),
		
		// vga
		.vga_clk       ( VGA_CLK ),
		.vga_hsync     ( VGA_HS ),
		.vga_vsync     ( VGA_VS ),
		.vga_blank     ( VGA_BLANK_N ),
		.vga_sync      ( VGA_SYNC_N ),
		.vga_r         ( VGA_R ),  
		.vga_g         ( VGA_G ),
		.vga_b         ( VGA_B ), 	
		
		// sdram
		.cs_n          ( DRAM_CS_N  ),
		.ras_n         ( DRAM_RAS_N  ),
		.cas_n         ( DRAM_CAS_N  ),
		.we_n          ( DRAM_WE_N  ),
		.dqm           ( {DRAM_UDQM, DRAM_LDQM} ),
		.sd_addr       ( dram_address  ),
		.ba            ( DRAM_BA  ),
		.Cke           ( DRAM_CKE  ),
		.sd_data       ( DRAM_DQ  ), 
		.sdram_clk     ( DRAM_CLK  ), 
		
		// tft screen
		.tft_sdo       (   ),
		.tft_sck       (   ), 
		.tft_sdi       (   ), 
		.tft_dc        (   ), 
		.tft_reset     (   ), 
		.tft_cs        (   ),
		
		// leds
		.LED           ( LEDR[9:0]  )
	);
	
	assign GPIO_1[0] = VGA_BLANK_N;

    //outputs


    assign HEX0 [6:0] = 7'h7f;
	assign HEX1 [6:0] = 7'h7f;
	assign HEX2 [6:0] = 7'h7f;
    assign HEX3 [6:0] = 7'h7f;
    assign HEX4 [6:0] = 7'h7f;
    assign HEX5 [6:0] = 7'h7f;

endmodule
