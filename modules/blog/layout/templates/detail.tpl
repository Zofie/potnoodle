{*
variables that are available:
- {$item}: contains data about the post
- {$comments}: contains an array with the comments for the post, each element contains data about the comment.
- {$commentsCount}: contains a variable with the number of comments for this blog post.
- {$navigation}: contains an array with data for previous and next post
*}

<div id="blogDetail">
	<article itemscope itemtype="http://schema.org/Blog">
		<div>
			<meta itemprop="interactionCount" content="UserComments:{$commentsCount}">
			<meta itemprop="author" content="{$item.user_id|usersetting:'nickname'}">
			<header>
				<h1 itemprop="name">{$item.title}</h1>
				<p>

					<!-- AUTHOR -->

					{* Written by *}
					{$msgWrittenBy|ucfirst|sprintf:{$item.user_id|usersetting:'nickname'}}

					{* Written on *}
					{$lblOn} <time itemprop="datePublished" datetime="{$item.publish_on|date:'Y-m-d\TH:i:s'}">{$item.publish_on|date:{$dateFormatLong}:{$LANGUAGE}}</time>

					<!-- CATEGORY -->

					{* Category*}
					{$lblIn} {$lblThe} {$lblCategory} <a itemprop="articleSection" href="{$item.category_full_url}" title="{$item.category_title}">{$item.category_title}</a>{option:!item.tags}.{/option:!item.tags}

					<!-- TAGS -->

					{* Tags *}
					{option:item.tags}
					{$lblWith} {$lblThe} {$lblTags}
					<span itemprop="keywords">
						{iteration:item.tags}
						<a href="{$item.tags.full_url}" rel="tag" title="{$item.tags.name}">{$item.tags.name}</a>{option:!item.tags.last}, {/option:!item.tags.last}{option:item.tags.last}.{/option:item.tags.last}
						{/iteration:item.tags}
					</span>
					{/option:item.tags}
				</p>
			</header>
			<div itemprop="articleBody">
				{option:item.image}
				<img src="{$FRONTEND_FILES_URL}/blog/images/128x128/{$item.image}" alt="{$item.title}" itemprop="image" />
				{/option:item.image}

				{$item.text}
			</div>

			<footer class="holder">

				<!-- SHARE -->

				<p>
					<a href="{$item.full_url}">{$lblShare|ucfirst}</a>
				</p>

				{option:navigation}
				{option:navigation.previous}
				<span>
					<a href="{$navigation.previous.url}" rel="prev">{$lblPreviousArticle|ucfirst}: {$navigation.previous.title}</a>
				</span> <br />
				{/option:navigation.previous}
				{option:navigation.next}
				<span>
					<a href="{$navigation.next.url}" rel="next">{$lblNextArticle|ucfirst}: {$navigation.next.title}</a>
				</span>
				{/option:navigation.next}
				{/option:navigation}
			</footer>
		</div>
	</article>

	{option:comments}
	{option:item.allow_comments}
	<section id="blogComments" itemscope itemtype="http://schema.org/Article">
		<header>
			<h3 id="{$actComments}">{$lblComments|ucfirst}</h3>
		</header>
		<div>
			{iteration:comments}
			{* Do not alter the id! It is used as an anchor *}
			<div id="comment-{$comments.id}" itemprop="comment" itemscope itemtype="http://schema.org/UserComments">
				<meta itemprop="discusses" content="{$item.title}" />
				<div>
					{option:comments.website}<a href="{$comments.website}">{/option:comments.website}
					<img src="{$FRONTEND_CORE_URL}/layout/images/default_author_avatar.gif" width="48" height="48" alt="{$comments.author}" class="replaceWithGravatar" data-gravatar-id="{$comments.gravatar_id}" />
					{option:comments.website}</a>{/option:comments.website}
				</div>
				<div>
					<p itemscope itemtype="http://schema.org/Person">
						{option:comments.website}<a href="{$comments.website}" itemprop="url">{/option:comments.website}
						<span itemprop="creator name">{$comments.author}</span>
						{option:comments.website}</a>{/option:comments.website}
						{$lblWrote}
						<time itemprop="commentTime" datetime="{$comments.created_on|date:'Y-m-d\TH:i:s'}">{$comments.created_on|timeago}</time>
					</p>
					<div itemprop="commentText">
						<blockquote>{$comments.text|cleanupplaintext}</blockquote>
					</div>
				</div>
			</div>
			{/iteration:comments}
		</div>
	</section>
	{/option:item.allow_comments}
	{/option:comments}
	{option:item.allow_comments}
	<section id="blogCommentForm">
		<header>
			<h3 id="{$actComment}">{$msgComment|ucfirst}</h3>
		</header>
		<div>
			{option:commentIsInModeration}<div class="message warning"><p>{$msgBlogCommentInModeration}</p></div>{/option:commentIsInModeration}
			{option:commentIsSpam}<div class="message error"><p>{$msgBlogCommentIsSpam}</p></div>{/option:commentIsSpam}
			{option:commentIsAdded}<div class="message success"><p>{$msgBlogCommentIsAdded}</p></div>{/option:commentIsAdded}
			{form:commentsForm}
			<div>
				<p {option:txtAuthorError}class="errorArea"{/option:txtAuthorError}>
					<label for="author">{$lblName|ucfirst}<abbr title="{$lblRequiredField}">*</abbr></label>
					{$txtAuthor} {$txtAuthorError}
				</p>
				<p {option:txtEmailError}class="errorArea"{/option:txtEmailError}>
					<label for="email">{$lblEmail|ucfirst}<abbr title="{$lblRequiredField}">*</abbr></label>
					{$txtEmail} {$txtEmailError}
				</p>
			</div>
			<p class="bigInput{option:txtWebsiteError} errorArea{/option:txtWebsiteError}">
				<label for="website">{$lblWebsite|ucfirst}</label>
				{$txtWebsite} {$txtWebsiteError}
			</p>
			<p class="bigInput{option:txtMessageError} errorArea{/option:txtMessageError}">
				<label for="message">{$lblMessage|ucfirst}<abbr title="{$lblRequiredField}">*</abbr></label>
				{$txtMessage} {$txtMessageError}
			</p>
			<p>
				<input type="submit" name="comment" value="{$msgComment|ucfirst}" />
			</p>
			{/form:commentsForm}
		</div>
	</section>
	{/option:item.allow_comments}
</div>