var UploaderTable = (function(href){
	return {
		cgi: href.replace(/^https:\/\/homepage/, 'http://hpcgi') + 'index.cgi',
		hiddenClass: 'hidden'
	};
})(location.href);
// テーブル作成
UploaderTable.make = function(fileOf) {
	var self = this;  // UploaderTable
	var hiddenClass = self.hiddenClass;

	var $table = $('<table/>')
		.append('<tr/>')
		.find(':last')
			.append('<th/>')
			.find(':last')
				.text('ファイル名（ダウンロード用リンク）')
			.end()
			.append('<th/>')
			.find(':last')
				.text('ダウンロード用パスワード')
			.end()
		.end();
	$.each(fileOf, function(id, file){
		var pass = file.pass || 'input pass';
		var label = file.label || file.file;

		var $label = $('<td/>')
					.append('<a/>')
					.find(':last')
						.attr('target', '_blank')
						.attr('href', self.cgi + '/dl?id=' + id)
						.text(label)
					.end()
					.append('<input type="text"/>')
					.find(':last')
						.addClass(hiddenClass)
						.val(label)
					.end()
					.children()
						.addClass('label')
					.end();

		var $pass = $('<td/>')
					.append('<span/>')
					.find(':last')
						.text(pass)
					.end()
					.append('<input type="text"/>')
					.find(':last')
						.addClass(hiddenClass)
						.val(pass)
					.end()
					.children()
						.addClass('pass')
					.end();

		$table
			.append('<tr/>')
			.find(':last')
				.attr('id', id)
				.append($label)
				.append($pass)
			.end();
	});

	// 描画 + クリックイベント
	$('#fileList')
	.append($table)
	.find('td')
		.click(function(e){
			var targetNodeName = $(e.target).get(0).nodeName;
			if (! /^(?:A|INPUT)$/.test(targetNodeName)) { // AとINPUTの時は何もしない
				self.editField(this);
			}
		})
		.find('input')
			.keyup(function(e){
				if (e.keyCode === 13) {
					self.commitField(this);
				}
			});

}
// テーブル内フィールドをinputにする、戻す
UploaderTable.editField = function(elem) {
	var self = this;
	var hiddenClass = this.hiddenClass;
	
	$(elem).children().toggleClass(hiddenClass);
}

// テーブル内データの更新
UploaderTable.updateField = function(dataOf) {
	var self = this;
	var hiddenClass = this.hiddenClass;

	$.each(dataOf, function(id, file){
		$.each(file, function(key, val){
			$('#' + id + ' .' + key).each(function(i, elem){
				var $inputOrNotElem = $(elem);
				if ($inputOrNotElem.get(0).nodeName === 'INPUT') {
					$inputOrNotElem.val(val);
				}
				else {
					$inputOrNotElem.text(val);
				}
			}).toggleClass(hiddenClass);
		});
	});
}

// テーブル内フィールド編集でcreate script
UploaderTable.commitField = function(elem) {
	var self = this; // UploaderTable

	var $input = $(elem);
	var requestData = {
		id: $input.parents('tr').attr('id')
	};
	requestData[$input.attr('class')] = $input.val();

	var $loadingImg = $('#loading');
	$loadingImg.show();
	$.getJSON(self.cgi + '/list/update?cb=?', requestData, function(data){
		$loadingImg.hide();
		self.updateField(data);
	});

}
