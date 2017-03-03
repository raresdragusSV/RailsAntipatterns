def post_to_facebook_feed(message, action_links)
  facebook_session.user.publish_to(
    facebook_session.user,
    message: message,
    action_links: action_links
  )
end

# rescuing all exceptions

FACEBOOK_ERRORS = [
  Facebooker::NonSessionUser,
  Facebooker::Session::SessionExpired,
  Facebooker::Session::UnknownError,
  Facebooker::Session::ServiceUnavailable,
  Facebooker::Session::MaxRequestsDepleted,
  Facebooker::Session::HostNotAllowed,
  Facebooker::Session::MissingOrInvalidParameter,
  Facebooker::Session::InvalidAPIKey,
  Facebooker::Session::CallOutOfOrder,
  Facebooker::Session::IncorrectSignature,
  Facebooker::Session::SignatureTooOld,
  Facebooker::Session::TooManyUserCalls,
  Facebooker::Session::TooManyUserActionCalls,
  Facebooker::Session::InvalidFeedTitleLink,
  Facebooker::Session::InvalidFeedTitleLength,
  Facebooker::Session::InvalidFeedTitleName,
  Facebooker::Session::BlankFeedTitle,
  Facebooker::Session::FeedBodyLengthTooLong
]

def post_to_facebook_feed(message, action_links)
  facebook_session.user.publish_to(
    facebook_session.user,
    message: message,
    action_links: action_links
  )
rescue *FACEBOOK_ERROS => facebook_error
  HoptoadNotifier.notify facebook_error
end
