Highcharts.theme = {
   colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
   chart: {
      backgroundColor: {
         linearGradient: [0, 0, 500, 500],
         stops: [
            [0, 'rgb(255, 255, 255)'],
            [1, 'rgb(240, 240, 255)']
         ]
      },
      borderWidth: 2,
      plotBackgroundColor: 'rgba(255, 255, 255, .9)',
      plotShadow: true,
      plotBorderWidth: 1
   },
   title: {
      style: {
         color: '#000',
         font: 'bold 16px "Trebuchet MS", Verdana, sans-serif'
      }
   },
   subtitle: {
      style: {
         color: '#666666',
         font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'
      }
   },
   xAxis: {
      gridLineWidth: 1,
      lineColor: '#000',
      tickColor: '#000',
      labels: {
         style: {
            color: '#000',
            font: '11px Trebuchet MS, Verdana, sans-serif'
         }
      },
      title: {
         style: {
            color: '#333',
            fontWeight: 'bold',
            fontSize: '12px',
            fontFamily: 'Trebuchet MS, Verdana, sans-serif'

         }
      }
   },
   yAxis: {
      minorTickInterval: 'auto',
      lineColor: '#000',
      lineWidth: 1,
      tickWidth: 1,
      tickColor: '#000',
      labels: {
         style: {
            color: '#000',
            font: '11px Trebuchet MS, Verdana, sans-serif'
         }
      },
      title: {
         style: {
            color: '#333',
            fontWeight: 'bold',
            fontSize: '12px',
            fontFamily: 'Trebuchet MS, Verdana, sans-serif'
         }
      }
   },
   legend: {
      itemStyle: {
         font: '9pt Trebuchet MS, Verdana, sans-serif',
         color: 'black'

      },
      itemHoverStyle: {
         color: '#039'
      },
      itemHiddenStyle: {
         color: 'gray'
      }
   },
   labels: {
      style: {
         color: '#99b'
      }
   }
};

var chart;

(function($){
	$.fn.bdiWeekChart = function(params)

	{   var count = 0;
		var transformCategoryData = [] ;
		params = params || {};
		var BIDDayData = params.data[0]['BIDDayData']; 
		var BIDIndex = BIDDayData['index'];
		var BIDRate = BIDDayData['change_rate'];  
		$.each(params.categories,function(index,item){
             transformCategoryData.push(item.split('-')[1]);  
		})
		chart = new Highcharts.Chart({
			chart: {
				renderTo: params.id || 'chartWeek' ,
				//defaultSeriesType: 'line',
				type: 'line',
				height: params.height || 190,
				width: params.width || 220,
				style: {margin: '0px auto'}
			},
			title: {
				useHTML:true,
				text: '<span style="background:#434343;padding:7px 27px ;margin-left:-16px;">BDI</span>',
				align: 'left',
				style: {
					//background:'red',
					color: '#FFFFFF',
					fontSize: '16px',
					fontWeight: 'bold'
				}
			},
			subtitle: {
				style:{
				  color: '#fff'	
				},
				useHTML:true,
					text:'<span style="position:absolute;left:-80px;font-size:16px;"><b style="background-color:#BB1919;padding:8px 10px 6px 10px">'+BIDIndex+'</b> <b style="background-color:#BB1919;padding:8px 16px 6px 16px;text-align:center;margin-left:-3px">'+BIDRate+"%"+'</b></span>',
				align: 'right',
				    x: -52,
				    y: 10 
			},
			
			xAxis: {
				//endOnTick: false,
	          //  startOnTick: false,
				//type: 'datetime',
				tickInterval: this.x,
				
	            //tickPixelInterval: 50,
				categories: transformCategoryData,
				labels: {
					//overflow: 'justify',
					//align: 'left',
					y: 15,
	                /*formatter: function() {console.log('this.x------>',this.x)}
//	                	var d = new Date(this.value);
//	                    return (d.getMonth() + 1) + "." + d.getDate() + "";
//	                }*/
	            }   
			},
           /* legend:{
                 backgroundColor: 'red',
                 labelFormatter:function(){
                 	console.log('this.x',thisleft:-80px;font-size:14px.x);
                 	return 'here is my chart'
                 }
            },*/
			yAxis: {
				tickInterval: 12, //this.y,
				title: {
					text: null
				},
				labels: {
					align: 'left',
					x: -10,
					y: 5,
					formatter: function() {

						return Highcharts.numberFormat(this.value, 0);
					}
				},
				showFirstLabel: false
			
			},
			
			legend: {
				enabled:false
			},
			
			credits: {
				enabled:false
			},

			tooltip: {
				labels:{
					align:'center'
				},  
				formatter: function() {
                    var data = params.categories; 
                        data = data[this.point.index];
					var d = data.split('-');
					return '<b>'+ d[0] + "月" + d[1] + "日" +'</b><br/><b>'+ this.series.name +'</b>:' + this.y;
				}
			},

			series: params.data || []
		});
       return $(this);
	}
	
	
	
})(jQuery);


//[["2011\/12\/10",1137.41],["2011\/12\/17",1134.74],["2011\/12\/24",1139.21],["2011\/12\/31",1140.96],["2012\/01\/07",1135.83],["2012\/01\/14",1123.66],["2012\/01\/21",1103.37],["2012\/02\/04",1097.57],["2012\/02\/11",1096.63],["2012\/02\/18",1118.28],["2012\/02\/25",1140.38],["2012\/03\/03",1158.92],["2012\/03\/10",1184.18],["2012\/03\/17",1223.52],["2012\/03\/24",1249.6],["2012\/03\/31",1242.87],["2012\/04\/07",1206.59],["2012\/04\/14",1185.11],["2012\/04\/21",1168.19],["2012\/04\/28",1155.71],["2012\/05\/05",1144.62],["2012\/05\/12",1122.66],["2012\/05\/19",1104.58],["2012\/05\/26",1090.05]]