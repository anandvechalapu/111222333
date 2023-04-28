using System.Collections.Generic;
using 111222333.DTO;

namespace 111222333.Service
{
    public interface ISharingOfUpsiService
    {
        Task<ICollection<SharingOfUpsiModel>> GetAllAsync();
        Task<SharingOfUpsiModel> GetByIdAsync(int id);
        Task<SharingOfUpsiModel> CreateAsync(SharingOfUpsiModel model);
        Task<SharingOfUpsiModel> UpdateAsync(SharingOfUpsiModel model);
        Task<bool> DeleteAsync(int id);
    }
}