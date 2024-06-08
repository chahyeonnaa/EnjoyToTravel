/**
 * 회원가입 관련 처리
 */
const root = "http://localhost:8080/enjoytrip";
let emailAuthCk = '';

document.addEventListener('DOMContentLoaded', function() {
	function fn_join() {
		let name = document.getElementById('name').value;
		let id = document.getElementById('id').value;
		let password = document.getElementById('password').value;
		let nickName = document.getElementById('nickName').value;
		let email = document.getElementById('email').value;
		let imgUrl = document.getElementById('imgUrl').value;

		let userData = {
			name: name,
			id: id,
			password: password,
			nickName: nickName,
			email: email,
			imgUrl: imgUrl
		};

		const url = root + '/user/signUp';
		fetch(url, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(userData)
		})
			.then(response => {
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				return response.text();
			})
			.then(data => {
				if (data === "true") {
					alert("회원가입이 완료되었습니다.");
					location.href = root + '/user/mvlogin';
				} else {
					alert("회원가입에 실패하였습니다.");
				}
			})
			.catch(error => {
				alert("회원가입 에러 발생!");
				console.error('Error during registration:', error);
			});
	}

	document.getElementById('signUp').addEventListener('click', function() {
		var id = document.getElementById('name').value;
		var id = document.getElementById('id').value;
		var nickname = document.getElementById('nickName').value;
		var password = document.getElementById('password').value;
		var passwordCk = document.getElementById('passwordCk').value;
		var emailAuthKey = document.getElementById('emailAuthKey').value;

		if (id === "") {
			alert("아이디를 입력해주세요.");
			return false;
		}

		if (nickname === "") {
			alert("닉네임을 입력해주세요.");
			return false;
		}

		if (password === "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		}

		if (password !== passwordCk) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}

		if (emailAuthKey !== emailAuthCk) {
			alert("인증번호가 일치하지 않습니다.");
			return false;
		}

		fn_join();
	});

	document.getElementById('emailAuthBtn').addEventListener('click', function() {
		let email = document.getElementById('email').value.trim();

		if (email === '') {
			alert("이메일을 입력해주세요.");
			return false;
		}

		let url = root + '/user/emailCheck';
		fetch(url, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ email: email })
		})
		.then(response => {
			if (!response.ok) {
				throw new Error('Network response was not ok');
			}
			return response.text();
		})
		.then(data => {
			console.log(data)
			if (data === "false") {
				url = root + '/user/emailAuth';
				fetch(url, {
					method: 'POST',
					body: JSON.stringify({ email: email }),
					headers: {
						'Content-Type': 'application/json'
					}
				})
					.then(response => {
						if (!response.ok) {
							throw new Error('Network response was not ok');
						}
						alert("인증번호가 발송되었습니다.");
						return response.text();
					})
					.then(data => {
						emailAuthCk = data;
					})
					.catch(error => {
						alert("메일 발송에 실패했습니다.");
						console.error('Error sending email:', error);
					});
			}
		})
		.catch(error => {
			console.error('Error checking nickname:', error);
		});
		
	});

	document.getElementById('id').addEventListener('blur', function() {
		let id = document.getElementById('id').value.trim();

		if (id === "") {
			alert("아이디를 입력해주세요.");
			return false;
		}

		const url = root + '/user/idCheck';
		fetch(url, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ id: id })
		})
			.then(response => {
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				return response.text();
			})
			.then(data => {
				if (data === "true") {
					document.getElementById('idCk').textContent = "이미 사용중인 아이디 입니다.";
				} else {
					document.getElementById('idCk').textContent = "사용 가능한 아이디 입니다.";
				}
			})
			.catch(error => {
				console.error('Error checking ID:', error);
			});
	});

	document.getElementById('nickName').addEventListener('focusout', function() {
		var nickName = document.getElementById('nickName').value.trim();

		if (nickName === "") {
			alert("닉네임을 입력해주세요.");
			return false;
		}

		const url = root + '/user/nickNameCheck';
		fetch(url, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ nickName: nickName })
		})
			.then(response => {
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				return response.text();
			})
			.then(data => {
				if (data === "true") {
					document.getElementById('nickNameCk').textContent = "이미 사용중인 닉네임 입니다.";
				} else {
					document.getElementById('nickNameCk').textContent = "사용 가능한 닉네임 입니다.";
				}
			})
			.catch(error => {
				console.error('Error checking nickname:', error);
			});
	});

});



