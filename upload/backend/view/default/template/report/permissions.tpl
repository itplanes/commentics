<?php echo $header; ?>

<div class="report_permissions_page">

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

	<table class="table">
		<thead>
			<tr>
				<th><?php echo $lang_column_file; ?></th>
				<th><?php echo $lang_column_information; ?></th>
				<th><?php echo $lang_column_result; ?></th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($files as $file) { ?>
				<tr>
					<td><?php echo $file['path']; ?></td>
					<td><?php echo $file['information']; ?></td>
					<?php if ($file['positive']) { ?>
						<td class="positive"><?php echo $file['text']; ?></td>
					<?php } else { ?>
						<td class="negative"><?php echo $file['text']; ?></td>
					<?php } ?>
				</tr>
			<?php } ?>
		</tbody>
	</table>

</div>

<?php echo $footer; ?>