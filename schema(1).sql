-- ============================================
-- 医院管理系统数据库Schema
-- 数据库: telemed
-- ============================================

-- ============================================
-- 删除数据库（如果存在，完全删除）
-- ============================================
-- 注意：删除数据库会删除所有数据，请谨慎操作！
DROP DATABASE IF EXISTS telemed;

-- ============================================
-- 创建数据库
-- ============================================
CREATE DATABASE IF NOT EXISTS telemed 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE telemed;

-- ============================================
-- 删除表（如果存在，按依赖关系倒序删除）
-- ============================================
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS special_treatments;
DROP TABLE IF EXISTS medicine_consultations;
DROP TABLE IF EXISTS medicine_stock_history;
DROP TABLE IF EXISTS user_permissions;
DROP TABLE IF EXISTS role_permissions;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS permissions;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS prescription_items;
DROP TABLE IF EXISTS prescriptions;
DROP TABLE IF EXISTS medical_records;
DROP TABLE IF EXISTS medicines;
DROP TABLE IF EXISTS queue_entries;
DROP TABLE IF EXISTS nurses;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- 创建表（按依赖关系顺序）
-- ============================================

-- 1. 创建用户表（基础表，无外键依赖）
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '密码',
    email VARCHAR(100) UNIQUE COMMENT '邮箱',
    phone_number VARCHAR(20) UNIQUE COMMENT '手机号',
    full_name VARCHAR(100) NOT NULL COMMENT '全名',
    user_type VARCHAR(20) NOT NULL COMMENT '用户类型：PATIENT, DOCTOR, ADMIN, NURSE, PHARMACIST',
    active BOOLEAN DEFAULT TRUE COMMENT '是否激活',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 2. 创建病人表（依赖users表）
CREATE TABLE patients (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '病人ID',
    user_id BIGINT NOT NULL COMMENT '关联的用户ID',
    id_card VARCHAR(18) UNIQUE COMMENT '身份证号',
    gender VARCHAR(10) COMMENT '性别：男、女',
    birth_date DATE COMMENT '出生日期',
    age INT COMMENT '年龄',
    blood_type VARCHAR(10) COMMENT '血型：A、B、AB、O',
    address TEXT COMMENT '地址',
    emergency_contact VARCHAR(100) COMMENT '紧急联系人',
    emergency_phone VARCHAR(20) COMMENT '紧急联系电话',
    allergy_history TEXT COMMENT '过敏史',
    medical_history TEXT COMMENT '既往病史',
    insurance_type VARCHAR(50) COMMENT '医保类型',
    insurance_number VARCHAR(50) COMMENT '医保号',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT '状态：ACTIVE, INACTIVE, ARCHIVED',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='病人表';

-- 3. 创建科室表（无外键依赖）
CREATE TABLE departments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '科室ID',
    name VARCHAR(50) NOT NULL UNIQUE COMMENT '科室名称',
    code VARCHAR(20) UNIQUE COMMENT '科室代码',
    description TEXT COMMENT '科室描述',
    location VARCHAR(100) COMMENT '科室位置',
    phone VARCHAR(20) COMMENT '联系电话',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT '状态：ACTIVE, INACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='科室表';

-- 4. 创建医生表（依赖users和departments表）
CREATE TABLE doctors (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '医生ID',
    user_id BIGINT NOT NULL COMMENT '关联的用户ID',
    department_id BIGINT COMMENT '关联的科室ID',
    department VARCHAR(50) NOT NULL COMMENT '科室名称（冗余字段，便于查询）',
    specialty VARCHAR(50) COMMENT '专科',
    title VARCHAR(50) COMMENT '职称：主任医师、副主任医师、主治医师等',
    qualifications TEXT COMMENT '资质',
    experience TEXT COMMENT '经验',
    availability TEXT COMMENT '可用时间',
    max_patients_per_day INT DEFAULT 20 COMMENT '每日最大接诊人数',
    current_queue_count INT DEFAULT 0 COMMENT '当前排队人数',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT '状态：ACTIVE, INACTIVE, ON_LEAVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='医生表';

-- 5. 创建护士表（依赖users和departments表）
CREATE TABLE nurses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '护士ID',
    user_id BIGINT NOT NULL COMMENT '关联的用户ID',
    department_id BIGINT COMMENT '关联的科室ID',
    department VARCHAR(50) NOT NULL COMMENT '科室名称（冗余字段，便于查询）',
    title VARCHAR(50) COMMENT '职称：护士长、主管护师、护师、护士等',
    qualifications TEXT COMMENT '资质',
    experience TEXT COMMENT '经验',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT '状态：ACTIVE, INACTIVE, ON_LEAVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='护士表';

-- 6. 创建排队记录表（依赖users、patients、doctors和departments表）
CREATE TABLE queue_entries (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '排队记录ID',
    user_id BIGINT NOT NULL COMMENT '关联的用户ID',
    patient_id BIGINT COMMENT '关联的病人ID',
    doctor_id BIGINT COMMENT '关联的医生ID',
    department_id BIGINT COMMENT '关联的科室ID',
    department VARCHAR(50) NOT NULL COMMENT '科室名称（冗余字段，便于查询）',
    queue_number VARCHAR(20) NOT NULL COMMENT '排队号',
    status VARCHAR(20) DEFAULT 'WAITING' COMMENT '状态：WAITING, PROCESSING, COMPLETED, CANCELLED, LEAVING, MISSED',
    estimated_wait_time INT DEFAULT 0 COMMENT '预计等待时间（分钟）',
    symptoms TEXT COMMENT '症状描述',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    called_at DATETIME COMMENT '叫号时间',
    completed_at DATETIME COMMENT '完成时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE SET NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE SET NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='排队记录表';

-- 6. 创建药品表（无外键依赖）
CREATE TABLE medicines (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '药品ID',
    name VARCHAR(100) NOT NULL COMMENT '药品名称',
    specification VARCHAR(100) COMMENT '规格',
    unit VARCHAR(20) COMMENT '单位',
    price DECIMAL(10, 2) DEFAULT 0.00 COMMENT '价格',
    stock INT DEFAULT 0 COMMENT '库存',
    description TEXT COMMENT '药品描述',
    usage_instructions TEXT COMMENT '用法用量',
    contraindications TEXT COMMENT '禁忌症',
    side_effects TEXT COMMENT '副作用',
    manufacturer VARCHAR(100) COMMENT '生产厂家',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='药品表';

-- 7. 创建处方表（依赖users、patients、doctors、queue_entries表）
CREATE TABLE prescriptions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '处方ID',
    queue_entry_id BIGINT COMMENT '关联的排队记录ID',
    user_id BIGINT NOT NULL COMMENT '患者用户ID',
    patient_id BIGINT COMMENT '关联的病人ID',
    doctor_id BIGINT NOT NULL COMMENT '医生ID',
    medical_record_number VARCHAR(50) UNIQUE COMMENT '病历号',
    diagnosis TEXT COMMENT '诊断结果',
    prescription_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '开方日期',
    status VARCHAR(20) DEFAULT 'PENDING' COMMENT '状态：PENDING, DISPENSED, COMPLETED, CANCELLED',
    picked_up BOOLEAN DEFAULT FALSE COMMENT '是否已取药',
    picked_up_at DATETIME COMMENT '取药时间',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE SET NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    FOREIGN KEY (queue_entry_id) REFERENCES queue_entries(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='处方表';

-- 8. 创建处方明细表（依赖prescriptions和medicines表）
CREATE TABLE prescription_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '处方明细ID',
    prescription_id BIGINT NOT NULL COMMENT '处方ID',
    medicine_id BIGINT NOT NULL COMMENT '药品ID',
    quantity INT NOT NULL COMMENT '数量',
    dosage VARCHAR(100) COMMENT '用量',
    usage_method VARCHAR(100) COMMENT '用法',
    frequency VARCHAR(50) COMMENT '频次',
    duration VARCHAR(50) COMMENT '疗程',
    notes TEXT COMMENT '备注',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='处方明细表';

-- 9. 创建病例表（依赖users、patients、doctors、queue_entries和prescriptions表）
CREATE TABLE medical_records (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '病例ID',
    user_id BIGINT NOT NULL COMMENT '患者用户ID',
    patient_id BIGINT COMMENT '关联的病人ID',
    doctor_id BIGINT NOT NULL COMMENT '医生ID',
    queue_entry_id BIGINT COMMENT '关联的排队记录ID',
    prescription_id BIGINT COMMENT '关联的处方ID',
    medical_record_number VARCHAR(50) UNIQUE COMMENT '病历号',
    chief_complaint TEXT COMMENT '主诉',
    present_illness TEXT COMMENT '现病史',
    past_history TEXT COMMENT '既往史',
    physical_examination TEXT COMMENT '体格检查',
    diagnosis TEXT COMMENT '诊断结果',
    treatment_plan TEXT COMMENT '治疗方案',
    doctor_notes TEXT COMMENT '医生备注',
    visit_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '就诊日期',
    next_visit_date DATETIME COMMENT '复诊日期',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT '状态：ACTIVE, ARCHIVED, DELETED',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE SET NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    FOREIGN KEY (queue_entry_id) REFERENCES queue_entries(id) ON DELETE SET NULL,
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='病例表';

-- 10. 创建通知表（依赖users表）
CREATE TABLE notifications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '通知ID',
    user_id BIGINT NOT NULL COMMENT '接收用户ID',
    title VARCHAR(200) NOT NULL COMMENT '通知标题',
    message TEXT NOT NULL COMMENT '通知内容',
    type VARCHAR(50) COMMENT '通知类型：QUEUE, PRESCRIPTION, SYSTEM等',
    status VARCHAR(20) DEFAULT 'UNREAD' COMMENT '状态：UNREAD, READ',
    related_id BIGINT COMMENT '关联ID（如排队ID、处方ID等）',
    related_type VARCHAR(50) COMMENT '关联类型',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    read_at DATETIME COMMENT '阅读时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知表';

-- 11. 创建角色表（无外键依赖）
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '角色ID',
    name VARCHAR(50) NOT NULL UNIQUE COMMENT '角色名称',
    description VARCHAR(200) COMMENT '角色描述',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- 12. 创建权限表（无外键依赖）
CREATE TABLE permissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '权限ID',
    name VARCHAR(50) NOT NULL UNIQUE COMMENT '权限名称',
    code VARCHAR(100) NOT NULL UNIQUE COMMENT '权限代码',
    description VARCHAR(200) COMMENT '权限描述',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限表';

-- 13. 创建用户角色关联表（依赖users和roles表）
CREATE TABLE user_roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '关联ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    role_id BIGINT NOT NULL COMMENT '角色ID',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_role (user_id, role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户角色关联表';

-- 14. 创建角色权限关联表（依赖roles和permissions表）
CREATE TABLE role_permissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '关联ID',
    role_id BIGINT NOT NULL COMMENT '角色ID',
    permission_id BIGINT NOT NULL COMMENT '权限ID',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
    UNIQUE KEY uk_role_permission (role_id, permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';

-- 15. 创建用户权限关联表（依赖users和permissions表）
CREATE TABLE user_permissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '关联ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    permission_id BIGINT NOT NULL COMMENT '权限ID',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_permission (user_id, permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户权限关联表';

-- 16. 创建药品库存变动记录表（依赖medicines和users表）
CREATE TABLE medicine_stock_history (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '记录ID',
    medicine_id BIGINT NOT NULL COMMENT '药品ID',
    quantity INT NOT NULL COMMENT '变动数量（正数为入库，负数为出库）',
    operation VARCHAR(20) NOT NULL COMMENT '操作类型：IN, OUT, ADJUST',
    before_stock INT COMMENT '变动前库存',
    after_stock INT COMMENT '变动后库存',
    operator_id BIGINT COMMENT '操作员ID',
    remark TEXT COMMENT '备注',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE CASCADE,
    FOREIGN KEY (operator_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='药品库存变动记录表';

-- 17. 创建用药咨询表（依赖users和medicines表）
CREATE TABLE medicine_consultations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '咨询ID',
    user_id BIGINT NOT NULL COMMENT '患者用户ID',
    medicine_id BIGINT COMMENT '药品ID',
    question TEXT NOT NULL COMMENT '问题内容',
    answer TEXT COMMENT '回复内容',
    pharmacist_id BIGINT COMMENT '药师ID',
    status VARCHAR(20) DEFAULT 'PENDING' COMMENT '状态：PENDING, ANSWERED',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    answered_at DATETIME COMMENT '回复时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(id) ON DELETE SET NULL,
    FOREIGN KEY (pharmacist_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用药咨询表';

-- 18. 创建特殊治疗申请表（依赖users、doctors、queue_entries表）
CREATE TABLE special_treatments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '申请ID',
    user_id BIGINT NOT NULL COMMENT '患者用户ID',
    doctor_id BIGINT COMMENT '申请医生ID',
    queue_entry_id BIGINT COMMENT '关联的排队记录ID',
    treatment_type VARCHAR(100) NOT NULL COMMENT '治疗类型',
    description TEXT COMMENT '治疗描述',
    reason TEXT COMMENT '申请原因',
    status VARCHAR(20) DEFAULT 'PENDING' COMMENT '状态：PENDING, APPROVED, REJECTED',
    approver_id BIGINT COMMENT '审批人ID',
    approval_opinion TEXT COMMENT '审批意见',
    approved_at DATETIME COMMENT '审批时间',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE SET NULL,
    FOREIGN KEY (queue_entry_id) REFERENCES queue_entries(id) ON DELETE SET NULL,
    FOREIGN KEY (approver_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='特殊治疗申请表';

-- ============================================
-- 创建索引（提高查询性能）
-- ============================================

-- 注意：username和email字段已有UNIQUE约束，会自动创建唯一索引
-- 这里只为非唯一字段创建索引

-- 用户表索引
-- username和email已有唯一索引，跳过
CREATE INDEX idx_users_phone ON users(phone_number);
CREATE INDEX idx_users_user_type ON users(user_type);

-- 病人表索引
-- user_id已有外键索引，跳过
CREATE INDEX idx_patients_id_card ON patients(id_card);
CREATE INDEX idx_patients_gender ON patients(gender);
CREATE INDEX idx_patients_status ON patients(status);

-- 科室表索引
CREATE INDEX idx_departments_name ON departments(name);
CREATE INDEX idx_departments_code ON departments(code);
CREATE INDEX idx_departments_status ON departments(status);

-- 医生表索引
-- user_id和department_id已有外键索引，跳过
CREATE INDEX idx_doctors_department ON doctors(department);
CREATE INDEX idx_doctors_department_id ON doctors(department_id);
CREATE INDEX idx_doctors_specialty ON doctors(specialty);
CREATE INDEX idx_doctors_status ON doctors(status);

-- 护士表索引
-- user_id和department_id已有外键索引，跳过
CREATE INDEX idx_nurses_department ON nurses(department);
CREATE INDEX idx_nurses_department_id ON nurses(department_id);
CREATE INDEX idx_nurses_status ON nurses(status);

-- 排队记录表索引
-- user_id、patient_id、doctor_id和department_id已有外键索引，跳过
CREATE INDEX idx_queue_entries_department ON queue_entries(department);
CREATE INDEX idx_queue_entries_department_id ON queue_entries(department_id);
CREATE INDEX idx_queue_entries_patient_id ON queue_entries(patient_id);
CREATE INDEX idx_queue_entries_status ON queue_entries(status);
CREATE INDEX idx_queue_entries_created_at ON queue_entries(created_at);

-- 病例表索引
-- user_id、patient_id、doctor_id、queue_entry_id和prescription_id已有外键索引，跳过
CREATE INDEX idx_medical_records_medical_record_number ON medical_records(medical_record_number);
CREATE INDEX idx_medical_records_patient_id ON medical_records(patient_id);
CREATE INDEX idx_medical_records_status ON medical_records(status);
CREATE INDEX idx_medical_records_visit_date ON medical_records(visit_date);

-- 药品表索引
CREATE INDEX idx_medicines_name ON medicines(name);
CREATE INDEX idx_medicines_stock ON medicines(stock);

-- 处方表索引
-- user_id、patient_id和doctor_id已有外键索引，跳过
-- medical_record_number已有唯一索引，跳过
CREATE INDEX idx_prescriptions_status ON prescriptions(status);
CREATE INDEX idx_prescriptions_patient_id ON prescriptions(patient_id);
CREATE INDEX idx_prescriptions_queue_entry_id ON prescriptions(queue_entry_id);
CREATE INDEX idx_prescriptions_medical_record_number ON prescriptions(medical_record_number);

-- 处方明细表索引
-- prescription_id和medicine_id已有外键索引，跳过
-- 如果需要复合查询，可以创建复合索引
CREATE INDEX idx_prescription_items_prescription_medicine ON prescription_items(prescription_id, medicine_id);

-- 通知表索引
-- user_id已有外键索引，跳过
CREATE INDEX idx_notifications_status ON notifications(status);
CREATE INDEX idx_notifications_created_at ON notifications(created_at);
CREATE INDEX idx_notifications_type ON notifications(type);

-- 库存历史表索引
-- medicine_id已有外键索引，跳过
CREATE INDEX idx_medicine_stock_history_created_at ON medicine_stock_history(created_at);
CREATE INDEX idx_medicine_stock_history_operation ON medicine_stock_history(operation);

-- 用药咨询表索引
-- user_id和medicine_id已有外键索引，跳过
CREATE INDEX idx_medicine_consultations_status ON medicine_consultations(status);
CREATE INDEX idx_medicine_consultations_pharmacist_id ON medicine_consultations(pharmacist_id);

-- 特殊治疗申请表索引
-- user_id、doctor_id、queue_entry_id已有外键索引，跳过
CREATE INDEX idx_special_treatments_status ON special_treatments(status);
CREATE INDEX idx_special_treatments_approver_id ON special_treatments(approver_id);
CREATE INDEX idx_special_treatments_treatment_type ON special_treatments(treatment_type);

-- ============================================
-- Schema创建完成
-- ============================================
