INSERT INTO tier_rulesets (version, rules, is_active, activated_at)
VALUES (
  '1.0.0',
  $$
  {
    "version": "1.0.0",
    "timezone": "UTC",
    "tiers": {
      "CADET": {
        "rank": 1,
        "capabilities": {
          "can_post": false,
          "can_comment": true,
          "can_like": true,
          "can_share": true,
          "can_create_group": false,
          "can_moderate_group": false
        },
        "limits": {
          "comments_per_hour": 20,
          "min_seconds_between_comments": 90,
          "posts_per_day": 0,
          "shares_per_day": 50
        },
        "promotion_to": {
          "target": "CONTRIBUTOR",
          "requirements": {
            "min_account_age_days": 7,
            "min_pot_score_7d": 120,
            "min_quality_comments_7d": 20,
            "min_positive_feedback_ratio": 0.60,
            "max_abuse_score": 1.50
          }
        }
      },
      "CONTRIBUTOR": {
        "rank": 2,
        "capabilities": {
          "can_post": true,
          "can_comment": true,
          "can_like": true,
          "can_share": true,
          "can_create_group": false,
          "can_moderate_group": false
        },
        "limits": {
          "comments_per_hour": 30,
          "min_seconds_between_comments": 45,
          "posts_per_day": 3,
          "shares_per_day": 100
        },
        "promotion_to": {
          "target": "STEWARD",
          "requirements": {
            "min_account_age_days": 30,
            "min_pot_score_30d": 800,
            "min_quality_posts_30d": 12,
            "min_positive_feedback_ratio": 0.68,
            "max_abuse_score": 1.00
          }
        }
      },
      "STEWARD": {
        "rank": 3,
        "capabilities": {
          "can_post": true,
          "can_comment": true,
          "can_like": true,
          "can_share": true,
          "can_create_group": true,
          "can_moderate_group": true
        },
        "limits": {
          "comments_per_hour": 40,
          "min_seconds_between_comments": 30,
          "posts_per_day": 8,
          "groups_owned_max": 3,
          "shares_per_day": 150
        }
      }
    },
    "proof_of_time": {
      "daily_base_visit_points": 5,
      "active_window": {
        "max_rewarded_windows_per_day": 3,
        "minimum_active_minutes_per_window": 8,
        "cooldown_minutes_between_windows": 120,
        "window_reward_points": {
          "1": 20,
          "2": 14,
          "3": 8
        }
      },
      "hard_caps": {
        "max_points_per_day": 120
      }
    }
  }
  $$::jsonb,
  TRUE,
  NOW()
)
ON CONFLICT (version) DO NOTHING;
