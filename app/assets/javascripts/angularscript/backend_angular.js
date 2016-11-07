angular.module("backendangular",[])
	.controller("Conversion",function($scope,$http){
		
		var hptokw = 0.746;
		var kwtohp = 1.34;
		var total = 0;
		$( "#HP" ).focus(function() {
		  $( "#HP" ).keyup(function(event) {
		  	var valhp = parseFloat( $( "#HP" ).val());
		  	if (valhp)
		  	{
		  		total = eval(valhp*hptokw);
			  	console.log(total);
			  	$( "#KW" ).val(total)
		  	}
		  	else
		  	{
		  		$( "#KW" ).val(0)
		  	};
		  	
		  });
		});
		$( "#KW" ).focus(function() {
		  $( "#KW" ).keyup(function(event) {
		  	var valkw = parseFloat( $( "#KW" ).val());
		  	if (valkw)
		  	{
		  		total = eval(valkw*kwtohp).toFixed(3);
			  	console.log(total);
			  	$( "#HP" ).val(total)
		  	}
		  	else
		  	{
		  		$( "#HP" ).val(0)
		  	};
		  	
		  });
		});
		
	})
	.controller("ConsultaArea", function ($scope,$http){

		selectsistemaid = $("#selectsistema option:selected").val();
		
		if (selectsistemaid != '')
		{

			id = $('#selectarea').val();
			$http.get('/areas/'+id+'.json')

			.success(function (data){
				// console.log(data.systems)
				$.each(data.systems, function(i,e) {
					// console.log(e.id+"y"+selectsistemaid);
					if ( e.id != selectsistemaid)
					{
						var option = new Option(e.name, e.id);
						$('#selectsistema').append($(option));

					};
					
				
	    		});
			})
			.error(function (err){

			});

		}
		else
		{
			console.log("no hay consulta");
		};

		
		$("#selectarea").change(function(event) {
			id = $(this).val();
			
			$('#selectsistema').empty();
			
			if (id != '')
			{
				$http.get('/areas/'+id+'.json')

				.success(function (data){
					console.log(data.systems)
					$.each(data.systems, function(i,e) {
						
						var option = new Option(e.name, e.id);
						$('#selectsistema').append($(option));
					
		    		});
		    		//$('#selectsistema').selectpicker()
				})
				.error(function (err){

				});
				
			};
		});

	})
	// .controller("CortaTexto", function ($scope){

	// 	$("#selectsistema").blur(function(event) {
	// 		var ELArea = $("#selectarea option:selected").text();
	// 		var ElSistema = $("#selectsistema option:selected").text();
	// 		var NevoCodigo= (ELArea.slice(0,3) + ElSistema.slice(0,3) + Myrandom() ) ;
	// 		$("#Codigo").val(NevoCodigo)
	// 		//console.log(NevoCodigo);
	// 	});
	
	// 	function Myrandom()
	// 	{
	// 	    var text = "";
	// 	    var possible = "0123456789aeiou";

	// 	    for( var i=0; i < 9; i++ )
	// 	        text += possible.charAt(Math.floor(Math.random() * possible.length));

	// 	    return text;
	// 	};

				
	// })
	.controller("GenerarCodigo" , function ($scope){
		$scope.generarcodigo = function ()
		 {
			var ELArea = $("#selectarea option:selected").text();
			var ValArea = $("#selectarea option:selected").val();
			var ElSistema = $("#selectsistema option:selected").text();
			var ValSistema = $("#selectsistema option:selected").val();

			if (ValSistema == "" || ValArea == "" )
			{
				alert("hay un select vacio")
			}
			else
			{
				var NevoCodigo= (ELArea.slice(0,3) + ElSistema.slice(0,3) + Myrandom() ) ;
				$("#Codigo").val(NevoCodigo)

			}
			console.log(ValArea);
		}
		function Myrandom()
		{
		    var text = "";
		    var possible = "0123456789aeiou";

		    for( var i=0; i < 9; i++ )
		        text += possible.charAt(Math.floor(Math.random() * possible.length));

		    return text;
		};
	})

