# README

## Models

- User
  - id: bigint
  - name: varchar
- SleepLog
  - id: bigint
  - created_at: datetime
  - wake_up_at: datetime
  - user_id: bigint
- Followers
  - user_id: bigint
  - follower_id: bigint

## APIs

- Create/end sleep log of current user
  - authenticate
  - buffer time to prevent double click issues
  - end latest created sleep log if there is any that are not ended
  - `POST /user/sleep_logs`
- Get all sleep logs of current user
  - ordered by created at, desc
  - `GET /user/sleep_logs`
- Follow
  - handle already follow scenario
  - `POST /user/followers/:follower_id`
- Unfollow
  - handle already unfollow scenario
  - `DELETE /user/followers/:follower_id`
- Get all sleep logs of followers
  - check if current user follows the target user
  - seep records over past week, ordered by the length of their sleep
  - `GET /user/followers/:follower_id/sleep_logs`
