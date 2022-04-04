package Service;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Inter.Command;
import Model.CommunityDAO;
import Model.CommunityDTO;
import Model.MemberDTO;

public class WriteArticleService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String article_category = "";
		try {
			// post��� ���ڵ�
			request.setCharacterEncoding("UTF-8");
		
			HttpSession session = request.getSession();
			MemberDTO info = (MemberDTO)session.getAttribute("info");
		    session.getAttribute("info");
		    String m_id = info.getM_id();
			
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
			
			CommunityDTO dto = new CommunityDTO();
			
			// ������ ��������
			String article_title = multi.getParameter("title");
			article_category = multi.getParameter("category");
			System.out.println("category : " + article_category);
			
			// �����̸��� �ѱ��� ������ ���ڵ�
			String article_file = multi.getOriginalFileName("fileName");;
			
			if(article_file == null) {
				dto.setArticle_file("");
			}else {
				dto.setArticle_file(URLEncoder.encode(multi.getFilesystemName("fileName"), "UTF-8"));
			}
			String article_content = multi.getParameter("content");
			

			System.out.println("title : " + article_title);
			System.out.println("writer : " + m_id);
			System.out.println("fileName : " + article_file);
			System.out.println("content : " + article_content);
			
			
			dto.setArticle_seq(0);
			dto.setArticle_title(article_title);
			dto.setArticle_content(article_content);
			dto.setArticle_date("");
			dto.setM_id(m_id);
			dto.setArticle_category(article_category);
			
			//String fileName = multi.getOriginalFileName("fileName");
			
			//if(fileName == null) {
			//	dto.setArticle_file("");
			//}
			//else {
			//	dto.setArticle_file(fileName);
			//}
			//
			int cnt = new CommunityDAO().Insert_C(dto);
			
			if(cnt>0) {
				System.out.println("���Ͼ��ε� ����");
			}else {
				System.out.println("���Ͼ��ε� ����");
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}

		return "commu_" + article_category +".jsp";
		// https://lkg3796.tistory.com/37
		// https://all-record.tistory.com/143
	}

}
