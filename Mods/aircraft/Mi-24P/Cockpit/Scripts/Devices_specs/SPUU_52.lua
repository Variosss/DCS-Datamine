minPos = 20.2  --��
maxPos = 29     --��

left_mark   = 0.715 -- ����� ������� ����������
right_mark  = 0.715 -- ������ ������� ����������
drive_speed = 0.8  --��/c

-- x_k = k_i*t + b_i_ + ((k_i+1_- k_i_)*t + b_i+1_ - b_i_) * (h_k - h_i_)/(h_i+1_ - h_i_) 
-- coeffs {{k_0,b_0,h_0},...{k_n,b_n,h_n}}

coeffs = {{0.11,24.2,0.0},{0.11,27.0,1000.0},{0.104,28.3,1500.0}}