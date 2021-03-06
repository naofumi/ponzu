<div id="session_details_presentation_{{= it.id }}">
  {{? it.art_thumb }}
    <img src="{{= it.art_thumb }}" class="thumb">
  {{?}}
  <div class="{{= it.type }}">
    <div class="time">
      {{= it.starts_at }}
    </div>
    <div class="number">
      {{= it.number }}
    </div>
    {{? !it.cancel }}
      <div class="title" style="clear:both">
        {{= it.title }}
      </div>
      <div class="authors">
        {{~ it.authorships :authorship:index}}
          <span class="author_{{= authorship.author_id}}">{{? authorship.is_presenting_author }}○{{?}}<span class="heart">&nbsp;</span><span class="club_out">&nbsp;</span><span class="club_in">&nbsp;</span><a href="#!_/authors/{{= authorship.author_id}}">{{= authorship.name}}</a>{{? index != (it.authorships.length - 1)}},{{?}}<sup>{{= authorship.affiliations.join(',') }}</sup></span>
        {{~}}
      </div>
      <div class="institutions">
        {{~ it.institutions :institution:index}}
          <div>
            <sup>{{= index + 1 }}</sup>
            {{= institution.name }}
          </div>
        {{~}}
      </div>
    {{??}}
      <div class="title">
        Presentation Cancelled
      </div>
    {{?}}
    <div data-ajax="/presentations/{{= it.id}}/social_box" id="presentation_{{= it.id}}_social_box"></div>
  </div>
</div>
