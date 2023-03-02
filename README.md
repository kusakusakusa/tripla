# README

## Models

- User
  - id: bigint
  - name: varchar
- SleepLog
  - id: bigint
  - created_at: datetime, index: true
  - wake_up_at: datetime
  - user_id: bigint
- Followings
  - user_id: bigint
  - friend_id: bigint
  - idx_user_friend

## APIs

- Create/end sleep log of current user
  - authenticate
  - buffer time to prevent double click issues
  - end latest created sleep log if there is any that are not ended
  - handle scenario where forgot to wake up?
  - `POST /user/sleep_logs`
- Get all sleep logs of current user
  - ordered by created at, desc
  - `GET /user/sleep_logs`
- Follow
  - handle already follow scenario
  - `POST /user/followings?friend_id`
- Unfollow
  - handle already unfollow scenario
  - `DELETE /user/followings/:id`
- Get all sleep logs of all friends, ranked by length of sleep
  - check if current user follows the target user
  - sleep records over past week, ordered by the length of their sleep, combine multiple sleep logs on the same day, determined by date of created_at
  - `GET /user/followings/sleep_logs`
