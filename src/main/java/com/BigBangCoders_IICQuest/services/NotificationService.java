package com.BigBangCoders_IICQuest.services;

import com.BigBangCoders_IICQuest.entities.HealthTip;

public interface NotificationService {
    void prepareDailyHealthTip();
    HealthTip getDailyHealthTip();
}
