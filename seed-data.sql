-- ============================================
-- 医院管理系统初始数据导入脚本
-- 数据库: telemed
-- ============================================
USE telemed;

-- ============================================
-- 1. 用户数据初始化
-- ============================================
-- 注意：密码使用BCrypt加密，这里使用明文，实际应用中应该加密存储
-- 默认密码格式：用户名123（例如：admin123, doctor1123等）

-- 管理员用户
INSERT INTO users (username, password, email, phone_number, full_name, user_type, active) VALUES
('admin', 'admin123', 'admin@hospital.com', '13800138000', '系统管理员', 'ADMIN', TRUE);

-- 医生用户（5个医生）
INSERT INTO users (username, password, email, phone_number, full_name, user_type, active) VALUES
('doctor1', 'doctor123', 'doctor1@hospital.com', '13900139001', '张医生', 'DOCTOR', TRUE),
('doctor2', 'doctor123', 'doctor2@hospital.com', '13900139002', '李医生', 'DOCTOR', TRUE),
('doctor3', 'doctor123', 'doctor3@hospital.com', '13900139003', '王医生', 'DOCTOR', TRUE),
('doctor4', 'doctor123', 'doctor4@hospital.com', '13900139004', '陈医生', 'DOCTOR', TRUE),
('doctor5', 'doctor123', 'doctor5@hospital.com', '13900139005', '刘医生', 'DOCTOR', TRUE);

-- 患者用户（10个患者）
INSERT INTO users (username, password, email, phone_number, full_name, user_type, active) VALUES
('patient1', 'patient123', 'patient1@hospital.com', '13700137001', '王患者', 'PATIENT', TRUE),
('patient2', 'patient123', 'patient2@hospital.com', '13700137002', '赵患者', 'PATIENT', TRUE),
('patient3', 'patient123', 'patient3@hospital.com', '13700137003', '孙患者', 'PATIENT', TRUE),
('patient4', 'patient123', 'patient4@hospital.com', '13700137004', '李患者', 'PATIENT', TRUE),
('patient5', 'patient123', 'patient5@hospital.com', '13700137005', '周患者', 'PATIENT', TRUE),
('patient6', 'patient123', 'patient6@hospital.com', '13700137006', '吴患者', 'PATIENT', TRUE),
('patient7', 'patient123', 'patient7@hospital.com', '13700137007', '郑患者', 'PATIENT', TRUE),
('patient8', 'patient123', 'patient8@hospital.com', '13700137008', '钱患者', 'PATIENT', TRUE),
('patient9', 'patient123', 'patient9@hospital.com', '13700137009', '冯患者', 'PATIENT', TRUE),
('patient10', 'patient123', 'patient10@hospital.com', '13700137010', '陈患者', 'PATIENT', TRUE);

-- 护士用户（3个护士）
INSERT INTO users (username, password, email, phone_number, full_name, user_type, active) VALUES
('nurse1', 'nurse123', 'nurse1@hospital.com', '13600136001', '张护士', 'NURSE', TRUE),
('nurse2', 'nurse123', 'nurse2@hospital.com', '13600136002', '李护士', 'NURSE', TRUE),
('nurse3', 'nurse123', 'nurse3@hospital.com', '13600136003', '王护士', 'NURSE', TRUE);

-- 药师用户（2个药师）
INSERT INTO users (username, password, email, phone_number, full_name, user_type, active) VALUES
('pharmacist1', 'pharmacist123', 'pharmacist1@hospital.com', '13500135001', '张药师', 'PHARMACIST', TRUE),
('pharmacist2', 'pharmacist123', 'pharmacist2@hospital.com', '13500135002', '李药师', 'PHARMACIST', TRUE);

-- ============================================
-- 2. 病人数据初始化
-- ============================================
INSERT INTO patients (user_id, id_card, gender, birth_date, age, blood_type, address, emergency_contact, emergency_phone, allergy_history, medical_history, insurance_type, insurance_number, status) VALUES
((SELECT id FROM users WHERE username = 'patient1'), '110101199001011234', '男', '1990-01-01', 34, 'A', '北京市朝阳区xxx街道', '王某某', '13800138001', '无', '无', '城镇职工医保', 'YB001234567', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient2'), '110101199002021234', '女', '1990-02-02', 34, 'B', '北京市海淀区xxx街道', '赵某某', '13800138002', '青霉素过敏', '高血压', '城镇居民医保', 'YB001234568', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient3'), '110101201001031234', '男', '2010-01-03', 14, 'O', '北京市西城区xxx街道', '孙某某', '13800138003', '无', '无', '儿童医保', 'YB001234569', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient4'), '110101198504041234', '女', '1985-04-04', 39, 'AB', '北京市东城区xxx街道', '李某某', '13800138004', '无', '糖尿病', '城镇职工医保', 'YB001234570', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient5'), '110101199505051234', '男', '1995-05-05', 29, 'A', '北京市丰台区xxx街道', '周某某', '13800138005', '无', '无', '城镇职工医保', 'YB001234571', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient6'), '110101199606061234', '女', '1996-06-06', 28, 'B', '北京市石景山区xxx街道', '吴某某', '13800138006', '海鲜过敏', '无', '城镇居民医保', 'YB001234572', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient7'), '110101198707071234', '男', '1987-07-07', 37, 'O', '北京市通州区xxx街道', '郑某某', '13800138007', '无', '无', '城镇职工医保', 'YB001234573', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient8'), '110101199808081234', '女', '1998-08-08', 26, 'A', '北京市昌平区xxx街道', '钱某某', '13800138008', '无', '无', '城镇居民医保', 'YB001234574', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient9'), '110101198909091234', '男', '1989-09-09', 35, 'B', '北京市大兴区xxx街道', '冯某某', '13800138009', '无', '无', '城镇职工医保', 'YB001234575', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'patient10'), '110101199010101234', '女', '1990-10-10', 34, 'AB', '北京市房山区xxx街道', '陈某某', '13800138010', '无', '无', '城镇居民医保', 'YB001234576', 'ACTIVE');

-- ============================================
-- 3. 科室数据初始化
-- ============================================
INSERT INTO departments (name, code, description, location, phone, status) VALUES
('内科', 'NK', '内科科室，主要诊治心血管、呼吸、消化等内科疾病', '1楼东侧', '010-12345678', 'ACTIVE'),
('外科', 'WK', '外科科室，主要诊治普外、骨科等外科疾病', '2楼西侧', '010-12345679', 'ACTIVE'),
('儿科', 'EK', '儿科科室，主要诊治儿童常见疾病', '3楼东侧', '010-12345680', 'ACTIVE'),
('妇产科', 'FCK', '妇产科科室，主要诊治妇科和产科疾病', '4楼西侧', '010-12345681', 'ACTIVE'),
('眼科', 'YK', '眼科科室，主要诊治眼部疾病', '5楼东侧', '010-12345682', 'ACTIVE');

-- ============================================
-- 4. 医生数据初始化
-- ============================================
INSERT INTO doctors (user_id, department_id, department, specialty, title, qualifications, experience, availability, max_patients_per_day, current_queue_count, status) VALUES
((SELECT id FROM users WHERE username = 'doctor1'), (SELECT id FROM departments WHERE name = '内科'), '内科', '心血管专家', '主任医师', '主任医师资格证', '15年', '周一至周五 8:00-17:00', 20, 0, 'ACTIVE'),
((SELECT id FROM users WHERE username = 'doctor2'), (SELECT id FROM departments WHERE name = '外科'), '外科', '普外科专家', '副主任医师', '副主任医师资格证', '10年', '周二至周六 9:00-16:00', 15, 0, 'ACTIVE'),
((SELECT id FROM users WHERE username = 'doctor3'), (SELECT id FROM departments WHERE name = '儿科'), '儿科', '小儿内科专家', '主治医师', '主治医师资格证', '8年', '周一至周五 9:00-17:00', 15, 2, 'ACTIVE'),
((SELECT id FROM users WHERE username = 'doctor4'), (SELECT id FROM departments WHERE name = '妇产科'), '妇产科', '产科专家', '主任医师', '主任医师资格证', '12年', '周三至周日 8:00-16:00', 10, 0, 'ACTIVE'),
((SELECT id FROM users WHERE username = 'doctor5'), (SELECT id FROM departments WHERE name = '眼科'), '眼科', '青光眼专家', '副主任医师', '副主任医师资格证', '9年', '周一、三、五 8:30-16:30', 12, 1, 'ACTIVE');

-- ============================================
-- 5. 护士数据初始化
-- ============================================
INSERT INTO nurses (user_id, department_id, department, title, qualifications, experience, status) VALUES
((SELECT id FROM users WHERE username = 'nurse1'), (SELECT id FROM departments WHERE name = '内科'), '内科', '主管护师', '主管护师资格证', '10年', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'nurse2'), (SELECT id FROM departments WHERE name = '外科'), '外科', '护师', '护师资格证', '5年', 'ACTIVE'),
((SELECT id FROM users WHERE username = 'nurse3'), (SELECT id FROM departments WHERE name = '儿科'), '儿科', '护士长', '护士长资格证', '15年', 'ACTIVE');

-- ============================================
-- 6. 药品数据初始化
-- ============================================
INSERT INTO medicines (name, specification, unit, price, stock, description, usage_instructions, contraindications, side_effects, manufacturer) VALUES
('阿莫西林胶囊', '0.25g*24粒', '盒', 28.50, 100, '广谱抗生素，用于治疗细菌感染', '口服，成人一次0.5g，一日3次', '对青霉素过敏者禁用', '偶见恶心、呕吐、皮疹等', '华北制药股份有限公司'),
('布洛芬缓释胶囊', '0.3g*12粒', '盒', 36.80, 80, '解热镇痛药，用于缓解疼痛和发热', '口服，成人一次0.3g，一日2次', '对本品过敏者、孕妇禁用', '偶见胃肠道不适', '中美天津史克制药有限公司'),
('盐酸左西替利嗪片', '5mg*6片', '盒', 45.00, 60, '抗过敏药，用于治疗过敏性疾病', '口服，成人一次5mg，一日1次', '对本品过敏者禁用', '偶见嗜睡、口干等', '重庆华邦制药有限公司'),
('奥美拉唑肠溶胶囊', '20mg*14粒', '盒', 58.00, 90, '质子泵抑制剂，用于治疗胃酸过多', '口服，成人一次20mg，一日1次', '对本品过敏者禁用', '偶见头痛、腹泻等', '阿斯利康制药有限公司'),
('阿司匹林肠溶片', '100mg*30片', '盒', 12.50, 150, '抗血小板聚集药，用于预防心脑血管疾病', '口服，成人一次100mg，一日1次', '对本品过敏者、活动性溃疡禁用', '偶见胃肠道不适', '拜耳医药保健有限公司'),
('头孢克肟胶囊', '0.1g*12粒', '盒', 42.00, 70, '第三代头孢菌素，用于治疗细菌感染', '口服，成人一次0.1g，一日2次', '对头孢菌素过敏者禁用', '偶见皮疹、腹泻等', '广州白云山制药股份有限公司'),
('复方甘草片', '50片', '瓶', 8.50, 200, '镇咳祛痰药，用于治疗咳嗽', '含服，一次2-3片，一日3次', '对本品过敏者禁用', '偶见恶心、呕吐', '北京同仁堂股份有限公司'),
('板蓝根颗粒', '10g*20袋', '盒', 15.00, 180, '清热解毒药，用于治疗感冒', '开水冲服，一次1袋，一日3次', '对本品过敏者禁用', '偶见胃肠道不适', '广州白云山和记黄埔中药有限公司'),
('维生素C片', '0.1g*100片', '瓶', 6.80, 300, '维生素补充剂，增强免疫力', '口服，一次1-2片，一日3次', '对本品过敏者禁用', '偶见胃肠道不适', '哈药集团制药六厂'),
('蒙脱石散', '3g*10袋', '盒', 18.00, 120, '止泻药，用于治疗腹泻', '口服，一次1袋，一日3次', '对本品过敏者禁用', '偶见便秘', '博福-益普生制药有限公司'),
('对乙酰氨基酚片', '0.5g*20片', '盒', 9.50, 250, '解热镇痛药，用于缓解疼痛和发热', '口服，成人一次0.5g，一日3-4次', '对本品过敏者、严重肝肾功能不全者禁用', '偶见皮疹、恶心等', '中美天津史克制药有限公司'),
('双氯芬酸钠缓释片', '75mg*10片', '盒', 32.00, 85, '非甾体抗炎药，用于缓解疼痛和炎症', '口服，成人一次75mg，一日1次', '对本品过敏者、活动性溃疡禁用', '偶见胃肠道不适、头痛等', '北京嘉林药业股份有限公司'),
('氨溴索口服溶液', '15mg/5ml*100ml', '瓶', 28.00, 95, '祛痰药，用于治疗痰多咳嗽', '口服，成人一次10ml，一日3次', '对本品过敏者禁用', '偶见胃肠道不适', '勃林格殷格翰药业有限公司'),
('氯雷他定片', '10mg*6片', '盒', 38.00, 75, '抗过敏药，用于治疗过敏性疾病', '口服，成人一次10mg，一日1次', '对本品过敏者禁用', '偶见嗜睡、口干等', '先灵葆雅制药有限公司'),
('甲硝唑片', '0.2g*21片', '盒', 5.50, 160, '抗厌氧菌药，用于治疗厌氧菌感染', '口服，成人一次0.2-0.4g，一日3次', '对本品过敏者、孕妇禁用', '偶见胃肠道不适、头痛等', '华北制药股份有限公司');

-- ============================================
-- 7. 排队记录数据初始化（示例数据）
-- ============================================
INSERT INTO queue_entries (user_id, patient_id, doctor_id, department_id, department, queue_number, status, estimated_wait_time, symptoms, created_at, called_at, completed_at) VALUES
-- 等待中的排队
((SELECT id FROM users WHERE username = 'patient1'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient1')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')), (SELECT id FROM departments WHERE name = '内科'), '内科', 'NK001', 'WAITING', 15, '头痛、发热', NOW() - INTERVAL 10 MINUTE, NULL, NULL),
((SELECT id FROM users WHERE username = 'patient2'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient2')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')), (SELECT id FROM departments WHERE name = '内科'), '内科', 'NK002', 'WAITING', 30, '咳嗽、胸闷', NOW() - INTERVAL 5 MINUTE, NULL, NULL),
((SELECT id FROM users WHERE username = 'patient4'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient4')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor3')), (SELECT id FROM departments WHERE name = '儿科'), '儿科', 'EK001', 'WAITING', 20, '儿童咳嗽', NOW() - INTERVAL 8 MINUTE, NULL, NULL),
((SELECT id FROM users WHERE username = 'patient5'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient5')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor5')), (SELECT id FROM departments WHERE name = '眼科'), '眼科', 'YK001', 'WAITING', 10, '视力模糊', NOW() - INTERVAL 3 MINUTE, NULL, NULL),
((SELECT id FROM users WHERE username = 'patient6'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient6')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor2')), (SELECT id FROM departments WHERE name = '外科'), '外科', 'WK001', 'WAITING', 25, '腹痛', NOW() - INTERVAL 15 MINUTE, NULL, NULL),
-- 处理中的排队
((SELECT id FROM users WHERE username = 'patient3'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient3')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor3')), (SELECT id FROM departments WHERE name = '儿科'), '儿科', 'EK002', 'PROCESSING', 0, '儿童发热', NOW() - INTERVAL 20 MINUTE, NOW() - INTERVAL 15 MINUTE, NULL),
((SELECT id FROM users WHERE username = 'patient7'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient7')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor4')), (SELECT id FROM departments WHERE name = '妇产科'), '妇产科', 'FCK001', 'PROCESSING', 0, '妇科检查', NOW() - INTERVAL 30 MINUTE, NOW() - INTERVAL 25 MINUTE, NULL),
-- 已完成的排队
((SELECT id FROM users WHERE username = 'patient8'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient8')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')), (SELECT id FROM departments WHERE name = '内科'), '内科', 'NK003', 'COMPLETED', 0, '感冒', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 2 DAY + INTERVAL 20 MINUTE, NOW() - INTERVAL 2 DAY + INTERVAL 30 MINUTE),
((SELECT id FROM users WHERE username = 'patient9'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient9')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor2')), (SELECT id FROM departments WHERE name = '外科'), '外科', 'WK002', 'COMPLETED', 0, '外伤处理', NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY + INTERVAL 15 MINUTE, NOW() - INTERVAL 1 DAY + INTERVAL 25 MINUTE),
((SELECT id FROM users WHERE username = 'patient10'), (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient10')), (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor5')), (SELECT id FROM departments WHERE name = '眼科'), '眼科', 'YK002', 'COMPLETED', 0, '视力检查', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 3 DAY + INTERVAL 10 MINUTE, NOW() - INTERVAL 3 DAY + INTERVAL 20 MINUTE);

-- ============================================
-- 8. 处方数据初始化（示例数据）
-- ============================================
INSERT INTO prescriptions (queue_entry_id, user_id, patient_id, doctor_id, medical_record_number, diagnosis, prescription_date, status, picked_up, picked_up_at) VALUES
-- 待取药处方
((SELECT id FROM queue_entries WHERE queue_number = 'NK001'), 
 (SELECT id FROM users WHERE username = 'patient1'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient1')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')), 
 'MR20241202001', '上呼吸道感染', NOW() - INTERVAL 1 DAY, 'PENDING', FALSE, NULL),
((SELECT id FROM queue_entries WHERE queue_number = 'NK003'), 
 (SELECT id FROM users WHERE username = 'patient8'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient8')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')), 
 'MR20241202003', '普通感冒', NOW() - INTERVAL 2 DAY, 'PENDING', FALSE, NULL),
-- 已配药处方
((SELECT id FROM queue_entries WHERE queue_number = 'EK002'), 
 (SELECT id FROM users WHERE username = 'patient3'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient3')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor3')), 
 'MR20241202002', '小儿感冒', NOW() - INTERVAL 2 DAY, 'DISPENSED', TRUE, NOW() - INTERVAL 1 DAY),
((SELECT id FROM queue_entries WHERE queue_number = 'WK002'), 
 (SELECT id FROM users WHERE username = 'patient9'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient9')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor2')), 
 'MR20241202004', '外伤处理', NOW() - INTERVAL 1 DAY, 'DISPENSED', TRUE, NOW() - INTERVAL 1 DAY + INTERVAL 2 HOUR),
-- 已完成处方
((SELECT id FROM queue_entries WHERE queue_number = 'YK002'), 
 (SELECT id FROM users WHERE username = 'patient10'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient10')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor5')), 
 'MR20241202005', '视力检查', NOW() - INTERVAL 3 DAY, 'COMPLETED', TRUE, NOW() - INTERVAL 3 DAY + INTERVAL 1 HOUR);

-- 处方明细
INSERT INTO prescription_items (prescription_id, medicine_id, quantity, dosage, usage_method, frequency, duration, notes) VALUES
-- MR20241202001 处方明细
((SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202001'), 
 (SELECT id FROM medicines WHERE name = '阿莫西林胶囊'), 
 2, '0.5g', '口服', '一日3次', '7天', '饭后服用'),
((SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202001'), 
 (SELECT id FROM medicines WHERE name = '布洛芬缓释胶囊'), 
 1, '0.3g', '口服', '一日2次', '3天', '发热时服用'),
-- MR20241202002 处方明细
((SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202002'), 
 (SELECT id FROM medicines WHERE name = '板蓝根颗粒'), 
 1, '10g', '开水冲服', '一日3次', '5天', '儿童减量服用'),
((SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202002'), 
 (SELECT id FROM medicines WHERE name = '对乙酰氨基酚片'), 
 1, '0.5g', '口服', '一日3次', '3天', '发热时服用'),
-- MR20241202003 处方明细
((SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202003'), 
 (SELECT id FROM medicines WHERE name = '复方甘草片'), 
 1, '2-3片', '含服', '一日3次', '5天', '饭后含服'),
((SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202003'), 
 (SELECT id FROM medicines WHERE name = '维生素C片'), 
 1, '1-2片', '口服', '一日3次', '7天', '增强免疫力'),
-- MR20241202004 处方明细
((SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202004'), 
 (SELECT id FROM medicines WHERE name = '头孢克肟胶囊'), 
 1, '0.1g', '口服', '一日2次', '5天', '饭后服用'),
((SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202004'), 
 (SELECT id FROM medicines WHERE name = '双氯芬酸钠缓释片'), 
 1, '75mg', '口服', '一日1次', '3天', '疼痛时服用');

-- ============================================
-- 9. 病例数据初始化（示例数据）
-- ============================================
INSERT INTO medical_records (user_id, patient_id, doctor_id, queue_entry_id, prescription_id, medical_record_number, chief_complaint, present_illness, past_history, physical_examination, diagnosis, treatment_plan, doctor_notes, visit_date, status) VALUES
-- 病例1：上呼吸道感染
((SELECT id FROM users WHERE username = 'patient1'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient1')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')), 
 (SELECT id FROM queue_entries WHERE queue_number = 'NK001'), 
 (SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202001'), 
 'MR20241202001', 
 '头痛、发热3天', 
 '患者3天前出现头痛、发热，体温最高38.5℃，伴有轻微咳嗽', 
 '既往体健，无特殊病史', 
 '体温38.2℃，咽部充血，心肺听诊未见异常', 
 '上呼吸道感染', 
 '抗感染治疗，多休息，多饮水', 
 '注意观察体温变化，如持续高热需复诊', 
 NOW() - INTERVAL 1 DAY, 
 'ACTIVE'),
-- 病例2：小儿感冒
((SELECT id FROM users WHERE username = 'patient3'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient3')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor3')), 
 (SELECT id FROM queue_entries WHERE queue_number = 'EK002'), 
 (SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202002'), 
 'MR20241202002', 
 '儿童发热2天', 
 '患儿2天前出现发热，体温最高39℃，伴有咳嗽、流涕', 
 '既往体健', 
 '体温38.8℃，咽部充血，双肺呼吸音粗', 
 '小儿感冒', 
 '对症治疗，物理降温，多饮水', 
 '注意观察患儿精神状态，如出现高热惊厥需立即就医', 
 NOW() - INTERVAL 2 DAY, 
 'ACTIVE'),
-- 病例3：普通感冒
((SELECT id FROM users WHERE username = 'patient8'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient8')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')), 
 (SELECT id FROM queue_entries WHERE queue_number = 'NK003'), 
 (SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202003'), 
 'MR20241202003', 
 '咳嗽、流涕2天', 
 '患者2天前出现咳嗽、流涕，无发热', 
 '既往体健', 
 '体温36.5℃，咽部轻度充血，心肺听诊未见异常', 
 '普通感冒', 
 '对症治疗，多休息，多饮水', 
 '注意休息，避免受凉', 
 NOW() - INTERVAL 2 DAY, 
 'ACTIVE'),
-- 病例4：外伤处理
((SELECT id FROM users WHERE username = 'patient9'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient9')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor2')), 
 (SELECT id FROM queue_entries WHERE queue_number = 'WK002'), 
 (SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202004'), 
 'MR20241202004', 
 '左手臂外伤1天', 
 '患者1天前不慎摔倒，左手臂擦伤，有少量出血', 
 '既往体健', 
 '左手臂可见3cm×2cm擦伤，已结痂，周围轻度红肿', 
 '外伤处理', 
 '抗感染治疗，定期换药', 
 '保持伤口清洁干燥，避免沾水', 
 NOW() - INTERVAL 1 DAY, 
 'ACTIVE'),
-- 病例5：视力检查
((SELECT id FROM users WHERE username = 'patient10'),
 (SELECT id FROM patients WHERE user_id = (SELECT id FROM users WHERE username = 'patient10')),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor5')), 
 (SELECT id FROM queue_entries WHERE queue_number = 'YK002'), 
 (SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202005'), 
 'MR20241202005', 
 '视力模糊1周', 
 '患者1周前出现视力模糊，看远处物体不清', 
 '既往体健', 
 '双眼视力：右眼0.6，左眼0.5，眼压正常，眼底检查未见异常', 
 '视力检查', 
 '建议配镜矫正，定期复查', 
 '注意用眼卫生，避免长时间用眼', 
 NOW() - INTERVAL 3 DAY, 
 'ACTIVE');

-- ============================================
-- 10. 通知数据初始化（示例数据）
-- ============================================
INSERT INTO notifications (user_id, title, message, type, status, related_id, related_type, created_at) VALUES
-- 排队提醒通知
((SELECT id FROM users WHERE username = 'patient1'), '排队提醒', '您已成功加入内科排队，当前排队号：NK001，预计等待时间：15分钟', 'QUEUE', 'UNREAD', 
 (SELECT id FROM queue_entries WHERE queue_number = 'NK001'), 'QUEUE_ENTRY', NOW() - INTERVAL 10 MINUTE),
((SELECT id FROM users WHERE username = 'patient2'), '排队提醒', '您已成功加入内科排队，当前排队号：NK002，预计等待时间：30分钟', 'QUEUE', 'UNREAD', 
 (SELECT id FROM queue_entries WHERE queue_number = 'NK002'), 'QUEUE_ENTRY', NOW() - INTERVAL 5 MINUTE),
((SELECT id FROM users WHERE username = 'patient4'), '排队提醒', '您已成功加入儿科排队，当前排队号：EK001，预计等待时间：20分钟', 'QUEUE', 'UNREAD', 
 (SELECT id FROM queue_entries WHERE queue_number = 'EK001'), 'QUEUE_ENTRY', NOW() - INTERVAL 8 MINUTE),
((SELECT id FROM users WHERE username = 'patient5'), '排队提醒', '您已成功加入眼科排队，当前排队号：YK001，预计等待时间：10分钟', 'QUEUE', 'UNREAD', 
 (SELECT id FROM queue_entries WHERE queue_number = 'YK001'), 'QUEUE_ENTRY', NOW() - INTERVAL 3 MINUTE),
((SELECT id FROM users WHERE username = 'patient6'), '排队提醒', '您已成功加入外科排队，当前排队号：WK001，预计等待时间：25分钟', 'QUEUE', 'UNREAD', 
 (SELECT id FROM queue_entries WHERE queue_number = 'WK001'), 'QUEUE_ENTRY', NOW() - INTERVAL 15 MINUTE),
-- 处方提醒通知
((SELECT id FROM users WHERE username = 'patient1'), '处方提醒', '您的处方已开具，请及时取药。病历号：MR20241202001', 'PRESCRIPTION', 'UNREAD', 
 (SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202001'), 'PRESCRIPTION', NOW() - INTERVAL 1 DAY),
((SELECT id FROM users WHERE username = 'patient3'), '处方提醒', '您的处方已开具，请及时取药。病历号：MR20241202002', 'PRESCRIPTION', 'UNREAD', 
 (SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202002'), 'PRESCRIPTION', NOW() - INTERVAL 2 DAY),
((SELECT id FROM users WHERE username = 'patient8'), '处方提醒', '您的处方已开具，请及时取药。病历号：MR20241202003', 'PRESCRIPTION', 'UNREAD', 
 (SELECT id FROM prescriptions WHERE medical_record_number = 'MR20241202003'), 'PRESCRIPTION', NOW() - INTERVAL 2 DAY),
-- 叫号通知
((SELECT id FROM users WHERE username = 'patient3'), '叫号提醒', '请到儿科诊室就诊，您的排队号：EK002', 'QUEUE', 'UNREAD', 
 (SELECT id FROM queue_entries WHERE queue_number = 'EK002'), 'QUEUE_ENTRY', NOW() - INTERVAL 15 MINUTE),
((SELECT id FROM users WHERE username = 'patient7'), '叫号提醒', '请到妇产科诊室就诊，您的排队号：FCK001', 'QUEUE', 'UNREAD', 
 (SELECT id FROM queue_entries WHERE queue_number = 'FCK001'), 'QUEUE_ENTRY', NOW() - INTERVAL 25 MINUTE);

-- ============================================
-- 11. 用药咨询数据初始化（示例数据）
-- ============================================
INSERT INTO medicine_consultations (user_id, medicine_id, question, answer, pharmacist_id, status, created_at) VALUES
((SELECT id FROM users WHERE username = 'patient1'), 
 (SELECT id FROM medicines WHERE name = '阿莫西林胶囊'), 
 '这个药可以空腹吃吗？', 
 '建议饭后服用，可以减少胃肠道不适。', 
 (SELECT id FROM users WHERE username = 'pharmacist1'), 
 'ANSWERED', NOW() - INTERVAL 1 DAY),
((SELECT id FROM users WHERE username = 'patient2'), 
 (SELECT id FROM medicines WHERE name = '布洛芬缓释胶囊'), 
 '这个药一天最多吃几次？', 
 NULL, 
 NULL, 
 'PENDING', NOW() - INTERVAL 2 HOUR);

-- ============================================
-- 12. 药品库存变动记录初始化（示例数据）
-- ============================================
INSERT INTO medicine_stock_history (medicine_id, quantity, operation, before_stock, after_stock, operator_id, remark, created_at) VALUES
((SELECT id FROM medicines WHERE name = '阿莫西林胶囊'), 100, 'IN', 0, 100, (SELECT id FROM users WHERE username = 'pharmacist1'), '初始入库', NOW() - INTERVAL 7 DAY),
((SELECT id FROM medicines WHERE name = '布洛芬缓释胶囊'), 80, 'IN', 0, 80, (SELECT id FROM users WHERE username = 'pharmacist1'), '初始入库', NOW() - INTERVAL 7 DAY),
((SELECT id FROM medicines WHERE name = '阿莫西林胶囊'), -2, 'OUT', 100, 98, (SELECT id FROM users WHERE username = 'pharmacist1'), '处方出库', NOW() - INTERVAL 1 DAY);

-- ============================================
-- 13. 角色和权限数据初始化（可选，如果系统使用RBAC）
-- ============================================
-- 角色
INSERT INTO roles (name, description) VALUES
('系统管理员', '拥有系统所有权限'),
('医生', '拥有医生相关权限'),
('患者', '拥有患者相关权限'),
('护士', '拥有护士相关权限'),
('药师', '拥有药师相关权限');

-- 权限（示例）
INSERT INTO permissions (name, code, description) VALUES
('用户管理', 'user:manage', '管理用户信息'),
('医生管理', 'doctor:manage', '管理医生信息'),
('排队管理', 'queue:manage', '管理排队信息'),
('处方管理', 'prescription:manage', '管理处方信息'),
('药品管理', 'medicine:manage', '管理药品信息'),
('通知管理', 'notification:manage', '管理通知信息');

-- 用户角色关联（示例）
INSERT INTO user_roles (user_id, role_id) VALUES
((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM roles WHERE name = '系统管理员')),
((SELECT id FROM users WHERE username = 'doctor1'), (SELECT id FROM roles WHERE name = '医生')),
((SELECT id FROM users WHERE username = 'patient1'), (SELECT id FROM roles WHERE name = '患者')),
((SELECT id FROM users WHERE username = 'nurse1'), (SELECT id FROM roles WHERE name = '护士')),
((SELECT id FROM users WHERE username = 'pharmacist1'), (SELECT id FROM roles WHERE name = '药师'));

-- ============================================
-- 14. 角色权限关联数据初始化
-- ============================================
INSERT INTO role_permissions (role_id, permission_id) VALUES
-- 系统管理员拥有所有权限
((SELECT id FROM roles WHERE name = '系统管理员'), (SELECT id FROM permissions WHERE code = 'user:manage')),
((SELECT id FROM roles WHERE name = '系统管理员'), (SELECT id FROM permissions WHERE code = 'doctor:manage')),
((SELECT id FROM roles WHERE name = '系统管理员'), (SELECT id FROM permissions WHERE code = 'queue:manage')),
((SELECT id FROM roles WHERE name = '系统管理员'), (SELECT id FROM permissions WHERE code = 'prescription:manage')),
((SELECT id FROM roles WHERE name = '系统管理员'), (SELECT id FROM permissions WHERE code = 'medicine:manage')),
((SELECT id FROM roles WHERE name = '系统管理员'), (SELECT id FROM permissions WHERE code = 'notification:manage')),
-- 医生拥有排队和处方管理权限
((SELECT id FROM roles WHERE name = '医生'), (SELECT id FROM permissions WHERE code = 'queue:manage')),
((SELECT id FROM roles WHERE name = '医生'), (SELECT id FROM permissions WHERE code = 'prescription:manage')),
-- 患者拥有通知管理权限（查看自己的通知）
((SELECT id FROM roles WHERE name = '患者'), (SELECT id FROM permissions WHERE code = 'notification:manage')),
-- 护士拥有排队管理权限
((SELECT id FROM roles WHERE name = '护士'), (SELECT id FROM permissions WHERE code = 'queue:manage')),
-- 药师拥有药品管理权限
((SELECT id FROM roles WHERE name = '药师'), (SELECT id FROM permissions WHERE code = 'medicine:manage'));

-- ============================================
-- 15. 用户权限关联数据初始化（可选，用于直接给用户分配权限）
-- ============================================
-- 这里可以为特定用户直接分配权限，而不通过角色
-- 示例：给管理员直接分配所有权限
INSERT INTO user_permissions (user_id, permission_id) VALUES
((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM permissions WHERE code = 'user:manage')),
((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM permissions WHERE code = 'doctor:manage')),
((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM permissions WHERE code = 'queue:manage')),
((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM permissions WHERE code = 'prescription:manage')),
((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM permissions WHERE code = 'medicine:manage')),
((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM permissions WHERE code = 'notification:manage'));

-- ============================================
-- 16. 特殊治疗申请数据初始化（示例数据）
-- ============================================
INSERT INTO special_treatments (user_id, doctor_id, queue_entry_id, treatment_type, description, reason, status, approver_id, approval_opinion, approved_at, created_at) VALUES
-- 待审批的特殊治疗申请
((SELECT id FROM users WHERE username = 'patient1'),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')),
 (SELECT id FROM queue_entries WHERE queue_number = 'NK001'),
 '特殊检查',
 '需要进行CT检查',
 '患者症状需要进一步检查确认',
 'PENDING',
 NULL,
 NULL,
 NULL,
 NOW() - INTERVAL 1 DAY),
-- 已批准的特殊治疗申请
((SELECT id FROM users WHERE username = 'patient8'),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor1')),
 (SELECT id FROM queue_entries WHERE queue_number = 'NK003'),
 '特殊用药',
 '需要使用特殊药物',
 '患者病情需要特殊药物治疗',
 'APPROVED',
 (SELECT id FROM users WHERE username = 'admin'),
 '同意申请，按医嘱执行',
 NOW() - INTERVAL 2 DAY + INTERVAL 1 HOUR,
 NOW() - INTERVAL 2 DAY),
-- 已拒绝的特殊治疗申请
((SELECT id FROM users WHERE username = 'patient9'),
 (SELECT id FROM doctors WHERE user_id = (SELECT id FROM users WHERE username = 'doctor2')),
 (SELECT id FROM queue_entries WHERE queue_number = 'WK002'),
 '特殊手术',
 '需要进行特殊手术',
 '患者申请特殊手术',
 'REJECTED',
 (SELECT id FROM users WHERE username = 'admin'),
 '不符合手术指征，建议保守治疗',
 NOW() - INTERVAL 1 DAY + INTERVAL 2 HOUR,
 NOW() - INTERVAL 1 DAY);

-- ============================================
-- 数据导入完成
-- ============================================
-- 导入的数据包括：
-- 1. 用户：1个管理员，5个医生，10个患者，3个护士，2个药师
-- 2. 病人：10个病人详细信息（关联用户，包含身份证、性别、年龄、血型、过敏史等）
-- 3. 科室：5个科室（内科、外科、儿科、妇产科、眼科）
-- 4. 医生：5个医生详细信息（关联科室）
-- 5. 护士：3个护士详细信息（关联科室）
-- 6. 药品：15种常用药品
-- 7. 排队记录：10条示例排队记录（包含WAITING、PROCESSING、COMPLETED等不同状态，全部关联病人）
-- 8. 处方：5条示例处方及明细（包含PENDING、DISPENSED、COMPLETED等不同状态，全部关联病人）
-- 9. 病例：5条示例病例（关联病人、医生、排队记录、处方）
-- 10. 通知：10条示例通知（包含排队提醒、处方提醒、叫号提醒等）
-- 11. 用药咨询：2条示例咨询
-- 12. 库存记录：3条示例库存变动记录
-- 13. 角色权限：5个角色，6个权限，5个用户角色关联
-- 14. 角色权限关联：11条角色权限关联记录
-- 15. 用户权限关联：6条用户权限关联记录（管理员直接权限）
-- 16. 特殊治疗申请：3条示例申请（包含PENDING、APPROVED、REJECTED等不同状态）

