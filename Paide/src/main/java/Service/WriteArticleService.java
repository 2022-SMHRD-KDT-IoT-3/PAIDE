package Service;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Inter.Command;
import Model.CommunityDAO;
import Model.CommunityDTO;

public class WriteArticleService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// post��� ���ڵ�
			request.setCharacterEncoding("UTF-8");
			
			// MultipartRequest ��ü�� �Ű����� ����
			// savePath : ������ ���� ���
			// ���� ���� ��ġ : WebContent
			// getServletContext() : ��û�� ���� ������ ����
			// getRealPath("ã�ư������ ������ �����) : ������ ������
			String savePath = request.getServletContext().getRealPath("./file");
			System.out.println(savePath);
			
			// maxsize : �̹����� ũ�� ����
			int maxsize = 10*1024*1024;
			// 1mb = 1024kb
			// lkb = 1024byte
			
			// encoding : ���
			String encoding = "UTF-8";
			
			// filePolicy : �����̸� �ߺ�����(���ϸ��� ��ĥ �� ���ڸ� �����ϰ� �ؼ� �ߺ������ϴ� ��ü)
			DefaultFileRenamePolicy filePolicy = new DefaultFileRenamePolicy();
			
			MultipartRequest multi = new MultipartRequest(request, savePath, maxsize, encoding, filePolicy);
			
			// ������ ��������
			String article_title = multi.getParameter("title");
			String m_id = multi.getParameter("writer");
			String article_category = multi.getParameter("category");
			// �����̸��� �ѱ��� ������ ���ڵ�
			String article_file = URLEncoder.encode(multi.getFilesystemName("fileName"), "UTF-8");
			String article_content = multi.getParameter("content");
			
			System.out.println("title : " + article_title);
			System.out.println("writer : " + m_id);
			System.out.println("fileName : " + article_file);
			System.out.println("content : " + article_content);
			
			CommunityDTO dto = new CommunityDTO(0, article_title, article_content, article_file, "", m_id, article_category);
			int cnt = new CommunityDAO().Insert_C(dto);
			
			if(cnt>0) {
				System.out.println("���Ͼ��ε� ����");
			}else {
				System.out.println("���Ͼ��ε� ����");
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}

		return null;
		// https://lkg3796.tistory.com/37
		// https://all-record.tistory.com/143
	}

}
