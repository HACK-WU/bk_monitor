--创建假数据的存储过程
create
    definer = root@localhost procedure InsertFakeDataToMetFeedback(IN num_records int)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE metric_id VARCHAR(128);
    DECLARE metric_hash VARCHAR(32);
    DECLARE biz_id INT;
    DECLARE feedback_value VARCHAR(16);
    DECLARE j INT;
    DECLARE max_id INT;

    SELECT MAX(id) INTO max_id FROM fta_web_metricrecommendationfeedback;
    IF (max_id IS NULL) THEN
        SET max_id = 0;
    END IF;


    -- 循环生成假数据
    WHILE i < num_records
        DO
            SET j = FLOOR(RAND() * 100);
            SET metric_id = CONCAT('metric_', j);
            SET metric_hash = CONCAT('metric_hash_', j);
            SET biz_id = FLOOR(RAND() * 5); -- 随机业务ID
            SET feedback_value = IF(RAND() > 0.5, 'good', 'bad');
            -- 随机选择good或bad

            -- 插入数据到表中
            INSERT INTO fta_web_metricrecommendationfeedback (is_enabled,
                                                              is_deleted,
                                                              create_user,
                                                              create_time,
                                                              update_user,
                                                              update_time,
                                                              alert_metric_id,
                                                              recommendation_metric_hash,
                                                              feedback,
                                                              bk_biz_id,
                                                              recommendation_metric)
            VALUES (1, -- is_enabled
                    0, -- is_deleted
                    CONCAT('user_', max_id + i), -- create_user
                    NOW(), -- create_time
                    CONCAT('user_', max_id + i), -- update_user
                    NOW(), -- update_time
                    metric_id,
                    metric_hash,
                    feedback_value,
                    biz_id,
                    CONCAT('{"example":"data"}') -- recommendation_metric
                   );

            SET i = i + 1;
        END WHILE;
END;

