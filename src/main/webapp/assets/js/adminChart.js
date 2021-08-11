
$({ val : 0 }).animate({ val : mcount }, {
	duration: 800,
	step: function() {
	  var num = numberWithCommas(Math.floor(this.val));
	  $(".mcountdiv").text(num);
	},
	complete: function() {
	  var num = numberWithCommas(Math.floor(this.val));
	  $(".mcountdiv").text(num);
	}
});
$({ val : 0 }).animate({ val : pcount }, {
	duration: 800,
	step: function() {
	  var num = numberWithCommas(Math.floor(this.val));
	  $(".pcountdiv").text(num);
	},
	complete: function() {
	  var num = numberWithCommas(Math.floor(this.val));
	  $(".pcountdiv").text(num);
	}
});

function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}



// <block:config:0>
const Sconfig = {
  type: 'line',
  data: Sdata,
  options: {
	responsive:true,
	 interaction: {
      mode: 'index',
      intersect: false,
    },
    plugins: {
      title: {
        display: true,
        text: '프로젝트/회원 사용 기술 순위',
		font:{
			size:30,
			weight:'bold',
		}
      }
    },
    scales: {
      y: {
        type: 'linear',
        display: true,
        position: 'left',

      },
      y1: {
        type: 'linear',
        display: true,
        position: 'right',
		suggestedMin:0
      }
    }
  },
};
// </block:config>

// <block:config:0>
const Pconfig = {
  type: 'line',
  data: Pdata,
  options: {
	responsive:true,
	 interaction: {
      mode: 'index',
      intersect: false,
    },
    plugins: {
      title: {
        display: true,
        text: '프로젝트/회원 선호 포지션 순위',
		font:{
			size:30,
			weight:'bold',
		}
      }
    },
    scales: {
      y: {
        type: 'linear',
        display: true,
        position: 'left',

      },
      y1: {
        type: 'linear',
        display: true,
        position: 'right',
		suggestedMin:0
      }
    }
  },
};
// </block:config>

// <block:config:0>
const Fconfig = {
  type: 'line',
  data: Fdata,
  options: {
	responsive:true,
	 interaction: {
      mode: 'index',
      intersect: false,
    },
    plugins: {
      title: {
        display: true,
        text: '프로젝트 참여 분야 순위',
		font:{
			size:30,
			weight:'bold',
		}
      }
    },
    scales: {
      y1: {
        type: 'linear',
        display: true,
        position: 'right',
		suggestedMin:0
      }
    }
  },
};
// </block:config>

const Stateconfig = {
  type: 'pie',
  data: Statedata,
  options: {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      title: {
        display: true,
        text: '상태별 프로젝트 수',
		font:{
			size:30,
			weight:'bold',
		}
      }
    }
  },
};
var SkillChart = new Chart(
	$('#SkillChart'),
	Sconfig
)

var PositionChart = new Chart(
	$('#PositionChart'),
	Pconfig
)

var FieldChart = new Chart(
	$('#FieldChart'),
	Fconfig
)
var StateChart = new Chart(
	$('#StateChart'),
	Stateconfig
)