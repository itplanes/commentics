<?php echo $header; ?>

<div class="manage_countries_page">

	<div class='page_help_block'><?php echo $page_help_link; ?></div>

	<h1><?php echo $lang_heading; ?></h1>

	<hr>

	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>

	<?php if ($info) { ?>
		<div class="info"><?php echo $info; ?></div>
	<?php } ?>

	<?php if ($error) { ?>
		<div class="error"><?php echo $error; ?></div>
	<?php } ?>

	<?php if ($warning) { ?>
		<div class="warning"><?php echo $warning; ?></div>
	<?php } ?>

	<div class="description"><?php echo $lang_description; ?></div>

	<div class="filter">
		<div class="row">
			<div class="column">
				<label><?php echo $lang_filter_name; ?></label>
				<input type="text" name="filter_name" value="<?php echo $filter_name; ?>">

				<label><?php echo $lang_filter_enabled; ?></label>
				<select name="filter_enabled">
					<option value=""><?php echo $lang_select_select; ?></option>
					<option value="1" <?php if ($filter_enabled == '1') { echo 'selected'; } ?>><?php echo $lang_text_yes; ?></option>
					<option value="0" <?php if ($filter_enabled == '0') { echo 'selected'; } ?>><?php echo $lang_text_no; ?></option>
				</select>
			</div>

			<div class="column">
				<label><?php echo $lang_filter_code; ?></label>
				<input type="text" name="filter_code" value="<?php echo $filter_code; ?>">

				<label><?php echo $lang_filter_date; ?></label>
				<input type="text" class="datepicker" name="filter_date" value="<?php echo $filter_date; ?>" placeholder="YYYY-MM-DD">
			</div>

			<div class="column">
				<label><?php echo $lang_filter_top; ?></label>
				<select name="filter_top">
					<option value=""><?php echo $lang_select_select; ?></option>
					<option value="1" <?php if ($filter_top == '1') { echo 'selected'; } ?>><?php echo $lang_text_yes; ?></option>
					<option value="0" <?php if ($filter_top == '0') { echo 'selected'; } ?>><?php echo $lang_text_no; ?></option>
				</select>

				<input type="button" id="filter" class="button" value="<?php echo $lang_button_filter; ?>" title="<?php echo $lang_button_filter; ?>">
			</div>
		</div>
	</div>

	<form action="index.php?route=manage/countries" class="controls" method="post">
		<div class="table_container">
			<table class="table">
				<thead>
					<tr>
						<th><input type="checkbox"></th>
						<th><a href="<?php echo $sort_name; ?>" <?php if ($sort == 'c.name') { echo 'class="' . $order . '"'; } ?>><?php echo $lang_column_name; ?></a></th>
						<th><a href="<?php echo $sort_code; ?>" <?php if ($sort == 'c.code') { echo 'class="' . $order . '"'; } ?>><?php echo $lang_column_code; ?></a></th>
						<th><a href="<?php echo $sort_top; ?>" <?php if ($sort == 'c.top') { echo 'class="' . $order . '"'; } ?>><?php echo $lang_column_top; ?></a></th>
						<th><a href="<?php echo $sort_enabled; ?>" <?php if ($sort == 'c.enabled') { echo 'class="' . $order . '"'; } ?>><?php echo $lang_column_enabled; ?></a></th>
						<th><a href="<?php echo $sort_date; ?>" <?php if ($sort == 'c.date_added') { echo 'class="' . $order . '"'; } ?>><?php echo $lang_column_date; ?></a></th>
						<th><?php echo $lang_column_action; ?></th>
					</tr>
				</thead>
				<tbody>
					<?php if ($countries) { ?>
						<?php foreach ($countries as $country) { ?>
							<tr>
								<td class="selector"><input type="checkbox" name="bulk[]" value="<?php echo $country['id']; ?>"></td>
								<td data-th="<?php echo $lang_column_name; ?>:"><?php echo $country['name']; ?></td>
								<td data-th="<?php echo $lang_column_code; ?>:"><a href="<?php echo $country['code_url']; ?>"><?php echo $country['code']; ?></a></td>
								<td data-th="<?php echo $lang_column_top; ?>:"><?php echo $country['top']; ?></td>
								<td data-th="<?php echo $lang_column_enabled; ?>:"><?php echo $country['enabled']; ?></td>
								<td data-th="<?php echo $lang_column_date; ?>:"><?php echo $country['date_added']; ?></td>
								<td class="actions">
									<a href="<?php echo $country['action']; ?>"><img src="<?php echo $button_edit; ?>" class="button_edit" title="<?php echo $lang_button_edit; ?>"></a>
									<a data-id="<?php echo $country['id']; ?>" class="single_delete"><img src="<?php echo $button_delete; ?>" class="button_delete" title="<?php echo $lang_button_delete; ?>"></a>
								</td>
							</tr>
						<?php } ?>
					<?php } else { ?>
					<tr>
						<td class="no_results" colspan="7"><?php echo $lang_text_no_results; ?></td>
					</tr>
				<?php } ?>
				</tbody>
			</table>
		</div>

		<input type="hidden" name="csrf_key" value="<?php echo $csrf_key; ?>">

		<p><input type="submit" name="bulk_delete" class="button" value="<?php echo $lang_button_delete; ?>" title="<?php echo $lang_button_delete; ?>"></p>
	</form>

	<div class="pagination_stats"><?php echo $pagination_stats; ?></div>

	<div class="pagination_links"><?php echo $pagination_links; ?></div>

	<div id="single_delete_dialog" title="<?php echo $lang_dialog_single_delete_title; ?>" style="display:none">
		<span class="ui-icon ui-icon-alert"></span> <?php echo $lang_dialog_single_delete_content; ?>
	</div>

	<div id="bulk_delete_dialog" title="<?php echo $lang_dialog_bulk_delete_title; ?>" style="display:none">
		<span class="ui-icon ui-icon-alert"></span> <?php echo $lang_dialog_bulk_delete_content; ?>
	</div>

	<script>
	// <![CDATA[
	$(document).ready(function() {
		$('#filter').click(function() {
			var url = 'index.php?route=manage/countries';

			var filter_name = $('input[name="filter_name"]').val();

			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}

			var filter_code = $('input[name="filter_code"]').val();

			if (filter_code) {
				url += '&filter_code=' + encodeURIComponent(filter_code);
			}

			var filter_top = $('select[name="filter_top"]').val();

			if (filter_top) {
				url += '&filter_top=' + encodeURIComponent(filter_top);
			}

			var filter_enabled = $('select[name="filter_enabled"]').val();

			if (filter_enabled) {
				url += '&filter_enabled=' + encodeURIComponent(filter_enabled);
			}

			var filter_date = $('input[name="filter_date"]').val();

			if (filter_date) {
				url += '&filter_date=' + encodeURIComponent(filter_date);
			}

			location = url;
		});
	});
	// ]]>
	</script>

	<script>
	// <![CDATA[
	$(document).ready(function() {
		$('input[name=\'filter_name\']').autocomplete({
			source: function(request, response) {
				$.ajax({
					type: 'GET',
					cache: false,
					url: 'index.php?route=manage/countries/autocomplete&filter_name=' + encodeURIComponent(request.term),
					dataType: 'json',
					success: function(data) {
						response($.map(data, function(item) {
							return {
								label: item.name,
								value: item.name
							}
						}));
					}
				});
			}
		});
	});
	// ]]>
	</script>

	<script>
	// <![CDATA[
	$(document).ready(function() {
		$('input[name=\'filter_code\']').autocomplete({
			source: function(request, response) {
				$.ajax({
					type: 'GET',
					cache: false,
					url: 'index.php?route=manage/countries/autocomplete&filter_code=' + encodeURIComponent(request.term),
					dataType: 'json',
					success: function(data) {
						response($.map(data, function(item) {
							return {
								label: item.code,
								value: item.code
							}
						}));
					}
				});
			}
		});
	});
	// ]]>
	</script>

	<script>
	// <![CDATA[
	$(document).ready(function() {
		$('.single_delete').click(function(e) {
			e.preventDefault();

			var id = $(this).data('id');

			$('#single_delete_dialog').dialog({
				modal: true,
				height: 'auto',
				width: 'auto',
				resizable: false,
				draggable: false,
				center: true,
				buttons: {
					'<?php echo $lang_dialog_yes; ?>': function() {
						var input = $('<input>').attr('type', 'hidden').attr('name', 'single_delete').val(id);

						$('form').append($(input));

						$('form').submit();

						$(this).dialog('close');
					},
					'<?php echo $lang_dialog_no; ?>': function() {
						$(this).dialog('close');
					}
				}
			});

			$('#single_delete_dialog').dialog('open');
		});
	});
	// ]]>
	</script>

	<script>
	// <![CDATA[
	$(document).ready(function() {
		$('input[name="bulk_delete"]').click(function(e) {
			e.preventDefault();

			$('#bulk_delete_dialog').dialog({
				modal: true,
				height: 'auto',
				width: 'auto',
				resizable: false,
				draggable: false,
				center: true,
				buttons: {
					'<?php echo $lang_dialog_yes; ?>': function() {
						$('form').submit();

						$(this).dialog('close');
					},
					'<?php echo $lang_dialog_no; ?>': function() {
						$(this).dialog('close');
					}
				}
			});

			$('#bulk_delete_dialog').dialog('open');
		});
	});
	// ]]>
	</script>

</div>

<?php echo $footer; ?>